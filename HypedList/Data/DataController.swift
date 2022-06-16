//
//  DataController.swift
//  HypedList
//
//  Created by Bikram Aryal on 16/06/2022.
//

import Foundation


class DataController: ObservableObject {
    
    static var shared = DataController()
    @Published var hypedEvents: [HypedEvent] = []
    
    var upcomingHypedEvent: [HypedEvent] {
        return hypedEvents.filter { $0.date > Date().dateAt(.startOfDay)}.sorted { $0.date < $1.date
        }
    }
    
    var pastHypedEvent: [HypedEvent] {
        return hypedEvents.filter { $0.date < Date().dateAt(.startOfDay)}.sorted { $0.date < $1.date
        }
    }
    
    
    
    func savedData() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.hypedEvents) {
                UserDefaults.standard.setValue(encoded, forKey: "hypedEvents")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func loadData() {
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
    
}