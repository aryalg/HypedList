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
