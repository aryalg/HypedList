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
    
    
    
}
