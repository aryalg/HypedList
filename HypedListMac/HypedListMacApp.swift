//
//  HypedListMacApp.swift
//  HypedListMac
//
//  Created by Bikram Aryal on 18/06/2022.
//

import SwiftUI

@main
struct HypedListMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    DataController.shared.loadData()
                    DataController.shared.getDiscoverEvents()
                }
        }
    }
}
