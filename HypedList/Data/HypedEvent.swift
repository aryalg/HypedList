//
//  HypedEvent.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import Foundation
import SwiftUI
import SwiftDate
import UIColorHexSwift


class HypedEvent: ObservableObject, Identifiable, Codable {
    
    @Published var id = UUID().uuidString
    
    @Published var date = Date()
    @Published var title = ""
    @Published var url = ""
    @Published var color = Color.purple
    @Published var imageData: Data?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case title
        case url
        case color
        case imageData
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(date, forKey: CodingKeys.date)
        try container.encode(title, forKey: CodingKeys.title)
        try container.encode(url, forKey: CodingKeys.url)
        
#if os(macOS)
        try container.encode(NSColor(color).hexString(), forKey: CodingKeys.color)
     
#else
        try container.encode(UIColor(color).hexString(), forKey: CodingKeys.color)
#endif
        
        
        try container.encode(imageData, forKey: CodingKeys.imageData)

        
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: CodingKeys.id)
        date = try values.decode(Date.self, forKey: CodingKeys.date)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        url = try values.decode(String.self, forKey: CodingKeys.url)
        let colorHex = try values.decode(String.self, forKey: .color)
#if os(macOS)
        color = try! Color(nsColor: NSColor(rgba_throws: colorHex))
#else
        color = Color(UIColor(colorHex))
#endif
        
        imageData = try? values.decode(Data.self, forKey: CodingKeys.imageData)
        
    }
    
    
    init(){
        
    }
    #if !os(watchOS)
    var hasBeenAdded: Bool {
        let hypedEvent =  DataController.shared.hypedEvents.first {  event -> Bool in
            return event.id == self.id
        }
        
        if hypedEvent != nil {
            return true
        } else {
            return false
        }
    }
    #endif
    
    
    
    func image() -> Image? {
        if let data = imageData {
            #if os(macOS)
            
            if let nsImage = NSImage(data: data) {
                return Image(nsImage: nsImage)
            }
            
            #else
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
            
            #endif
           
        }
        
        return nil
    }
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        
        if(date.compare(.isThisYear)) {
            formatter.dateFormat = "MMM d"
        } else {
            formatter.dateFormat = "MMM d yyyy"
        }
        
//    https://nsdateformatter.com/
        
        return formatter.string(from: date)
        
        
    }
    
    func timeFromNow() -> String {
        return date.toRelative()
    }
    
    
    func validURL () -> URL? {
        return URL(string: url)
    }
    
}


var testHypedEvent1: HypedEvent {
    let hypedEvent = HypedEvent()
    
    #if os(macOS)
    if let image = NSImage(named: "wwdc") {
        if let  data = image.tiffRepresentation {
            hypedEvent.imageData = data
        }
    }
    #else
    if let image = UIImage(named: "wwdc") {
        if let  data = image.pngData() {
            hypedEvent.imageData = data
        }
    }
    #endif
    
    hypedEvent.title = "WWDC 2021"
    hypedEvent.color = .green
    hypedEvent.date = Date() + 4.days + 1.years
    hypedEvent.url = "apple.com"
    
    return hypedEvent
}

var testHypedEvent2: HypedEvent {
    let hypedEvent = HypedEvent()

    hypedEvent.title = "Family and Friends Trip to Jackson and then Arizona"
    hypedEvent.color = .blue
    hypedEvent.date = Date() + 2.hours
    
    return hypedEvent
}
