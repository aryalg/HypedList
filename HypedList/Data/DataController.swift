//
//  DataController.swift
//  HypedList
//
//  Created by Bikram Aryal on 16/06/2022.
//

import Foundation
import SwiftDate
import UIKit
import UIColorHexSwift
import SwiftUI


class DataController: ObservableObject {
    
    static var shared = DataController()
    @Published var hypedEvents: [HypedEvent] = []
    @Published var discoverHypedEvents: [HypedEvent] = []
    
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
    
    func getDiscoverEvents() {
        if let url = URL(string: "https://api.jsonbin.io/b/62ab8106402a5b38022b0662/latest") {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                if let webData = data {
                    if let json = try? JSONSerialization.jsonObject(with: webData, options: []) as? [[String:String]] {
                        
                        var hypedEventsToAdd: [HypedEvent] = []
                        
                        for jsonHypedEvent in json {
                            let hypedEvent = HypedEvent()
                            if let id = jsonHypedEvent["id"] {
                                hypedEvent.id = id
                            }
                            
                            if let dateString = jsonHypedEvent["date"] {
                                if let dateInRegion = dateString.toDate() {
                                    hypedEvent.date = dateInRegion.date
                                }
                                
                            }
                            
                            if let title = jsonHypedEvent["title"] {
                                hypedEvent.title = title
                            }
                            
                            if let url = jsonHypedEvent["url"] {
                                hypedEvent.url = url
                            }
                            
                            if let colorHex = jsonHypedEvent["color"] {
                                hypedEvent.color = Color(UIColor(colorHex))
                            }
                            
                            if let imageUrl = jsonHypedEvent["imageUrl"] {
//                                hypedEvent.imageData = id
                            }
                            hypedEventsToAdd.append(hypedEvent)
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.discoverHypedEvents = hypedEventsToAdd
                        }
                        
                        
                    }
                }
            }.resume()
        }
//    https://api.jsonbin.io/b/62ab8106402a5b38022b0662
    }
    
}
