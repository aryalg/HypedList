//
//  PhoneToWatchDataController.swift
//  HypedListWatch WatchKit Extension
//
//  Created by Bikram Aryal on 18/06/2022.
//

import Foundation
import WatchConnectivity

class PhoneToWatchDataController: NSObject, WCSessionDelegate {
    
    
    static var shared = PhoneToWatchDataController()
    
    var session: WCSession?
    
    func setupSession() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("activated")
         default:
            print("not able to talk to watch :(")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Now Inactive :(")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Deactivated :( :(")
    }
    
    func sendContext(context: [String: Any]) {
        try? session?.updateApplicationContext(context)
    }
    
    
    func convertHypedEventsToContext(hypedEvents: [HypedEvent]) -> [String:Any] {
        var imagelessHypedEvents: [HypedEvent] = []
        for hypedEvent in hypedEvents {
            let imagelessHypedEvent = HypedEvent()
            imagelessHypedEvent.title = hypedEvent.title
            imagelessHypedEvent.id = hypedEvent.id
            imagelessHypedEvent.color = hypedEvent.color
            imagelessHypedEvent.url = hypedEvent.url
            imagelessHypedEvent.date = hypedEvent.date
            
            imagelessHypedEvents.append(imagelessHypedEvent)
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(imagelessHypedEvents) {
            return ["hypedEvents": encoded]
        }
        return ["failed": 0]
    }
    
    
}
