//
//  WatchToPhoneDataController.swift
//  HypedListWatch WatchKit Extension
//
//  Created by Bikram Aryal on 18/06/2022.
//


import Foundation
import WatchConnectivity

class WatchToPhoneDataController: NSObject, WCSessionDelegate, ObservableObject {
    
    
    static var shared = WatchToPhoneDataController()
    
    @Published var hypedEvents: [HypedEvent] = []
    
    
    
    var session = WCSession.default
    
    override init() {
        super.init()
        
        session.delegate = self
        session.activate()
        
        
        DispatchQueue.global().async {
            if let data = UserDefaults.standard.data(forKey: "hypedEvents") {
                let decoder = JSONDecoder()
                if let savedHypedEvent = try? decoder.decode([HypedEvent].self, from: data) {
                    DispatchQueue.main.async {
                        self.hypedEvents = savedHypedEvent
                      
                    }
                   
                }
            
            }
            
        }

    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("activated from watch")
            sendMessage()
         default:
            print("not able to talk to watch :(")
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
        decodeContext(context: applicationContext)
        
        
        
    }
    
    func decodeContext(context: [String: Any]) {
        print("decodingContext in applew watch")
        if let hypedData = context["hypedEvents"] as? Data {
            let decoder = JSONDecoder()
            
            if let decodedHypedData = try? decoder.decode([HypedEvent].self, from: hypedData) {
                DispatchQueue.main.async {
                    self.hypedEvents = decodedHypedData
                    
                    DispatchQueue.global().async {
                        
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(self.hypedEvents) {
                            UserDefaults.standard.setValue(encoded, forKey: "hypedEvents")
                            UserDefaults.standard.synchronize()
                            
                        }
                    
                    }
                }
               
                
            }
        }
    }
    
    
    func sendMessage() {
        session.sendMessage(["I want":"Data"]) { (context) in
            self.decodeContext(context: context)
        } errorHandler: { (error) in
            print(error)
        }
    }
    
  
    
}

