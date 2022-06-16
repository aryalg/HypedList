//
//  HypedEvent.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import Foundation
import SwiftUI


class HypedEvent: ObservableObject {
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
    hypedEvent.date = Date()
    hypedEvent.url = "apple.com"
    
    return hypedEvent
}

var testHypedEvent2: HypedEvent {
    let hypedEvent = HypedEvent()

    hypedEvent.title = "Family Trip to Jackson"
    hypedEvent.color = .blue
    hypedEvent.date = Date()
    
    return hypedEvent
}
