//
//  HypedEvent.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import Foundation
import SwiftUI
import SwiftDate


class HypedEvent: ObservableObject, Identifiable {
    
    var id = UUID().uuidString
    
    var date = Date()
    var title = ""
    var url = ""
    var color = Color.purple
    @Published var imageDate: Data?
    
    func image() -> Image? {
        if let data = imageDate {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
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
    
}


var testHypedEvent1: HypedEvent {
    let hypedEvent = HypedEvent()
    
    if let image = UIImage(named: "wwdc") {
        if let  data = image.pngData() {
            hypedEvent.imageDate = data
        }
    }
    
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
