//
//  DataController.swift
//  HypedList
//
//  Created by Bikram Aryal on 16/06/2022.
//

import Foundation
import SwiftDate
import UIColorHexSwift
import SwiftUI
import WidgetKit


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
            if let defaults = UserDefaults(suiteName: "group.au.com.bitpointx.HypedList") {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.hypedEvents) {
                defaults.setValue(encoded, forKey: "hypedEvents")
                defaults.synchronize()
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
#if !os(macOS)
            PhoneToWatchDataController.shared.sendContext(context: PhoneToWatchDataController.shared.convertHypedEventsToContext(hypedEvents: self.upcomingHypedEvent))
            #endif
        }
    }
    
    
    func addFromDiscover(hypedEvent: HypedEvent) {
        hypedEvents.append(hypedEvent)
        hypedEvent.objectWillChange.send()
        savedData()
    }
    
    func deleteHypedEvent(hypedEvent: HypedEvent) {
        if let index = hypedEvents.firstIndex(where: { loopingHypedEvent -> Bool in
            return hypedEvent.id == loopingHypedEvent.id
        }) {
            hypedEvents.remove(at: index)
            savedData()
        }
        
    }
    
    func saveHypedEvent(hypedEvent: HypedEvent) {
        if let index = hypedEvents.firstIndex(where: { loopingHypedEvent -> Bool in
            return hypedEvent.id == loopingHypedEvent.id
        }) {
           hypedEvents[index] = hypedEvent
          
        } else {
            hypedEvents.append(hypedEvent)
        }
        savedData()
    }
    
    func loadData() {
        DispatchQueue.global().async {
            if let defaults = UserDefaults(suiteName: "group.au.com.bitpointx.HypedList") {
            if let data = defaults.data(forKey: "hypedEvents") {
                let decoder = JSONDecoder()
                if let savedHypedEvent = try? decoder.decode([HypedEvent].self, from: data) {
                    DispatchQueue.main.async {
                        self.hypedEvents = savedHypedEvent
                        #if !os(macOS)
                        PhoneToWatchDataController.shared.sendContext(context: PhoneToWatchDataController.shared.convertHypedEventsToContext(hypedEvents: self.upcomingHypedEvent))
                        #endif
                    }
                   
                }
            }
            }
            
        }
    }
    
    func getUpcomingForWidget() -> [HypedEvent] {
        if let defaults = UserDefaults(suiteName: "group.au.com.bitpointx.HypedList") {
        if let data = defaults.data(forKey: "hypedEvents") {
            let decoder = JSONDecoder()
            if let savedHypedEvent = try? decoder.decode([HypedEvent].self, from: data) {
                
                return savedHypedEvent;
                
               
            }
        }
        }
        
        return []
     

    }
    
    func getDiscoverEvents() {
        if let url = URL(string: "https://api.jsonbin.io/b/62ab8106402a5b38022b0662/latest") {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                do {
                if let webData = data {
                    if let json = try? JSONSerialization.jsonObject(with: webData, options: []) as? [[String:String]] {
                        
                        var hypedEventsToAdd: [HypedEvent] = []
                        
                        for jsonHypedEvent in json {
                            let hypedEvent = HypedEvent()
                            if let id = jsonHypedEvent["id"] {
                                hypedEvent.id = id
                            }
                            
                            if let dateString = jsonHypedEvent["date"] {
                                SwiftDate.defaultRegion = Region.local
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
                             
                                #if os(macOS)
                                if let nsColor = try? Color(NSColor(rgba_throws: "#" + colorHex)) {
                                hypedEvent.color = nsColor
                                }
                                #else
                                hypedEvent.color = Color(UIColor("#" + colorHex))
                                #endif
                                
                            }
                            
                            if let imageUrl = jsonHypedEvent["imageURL"] {
                                if let url = URL(string: imageUrl) {
                                    if let data = try? Data(contentsOf: url) {
                                        hypedEvent.imageData = data
                                    }
                                }
                            }
                            hypedEventsToAdd.append(hypedEvent)
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.discoverHypedEvents = hypedEventsToAdd
                        }
                        
                        
                    }
                }
                } catch {
                    
                }
            }.resume()
        }
//    https://api.jsonbin.io/b/62ab8106402a5b38022b0662
    }
    
}
