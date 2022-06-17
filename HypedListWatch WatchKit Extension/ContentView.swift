//
//  ContentView.swift
//  HypedListWatch WatchKit Extension
//
//  Created by Bikram Aryal on 18/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject var data = WatchToPhoneDataController.shared
    
    var body: some View {
        HypedEventWatchListView(hypedEvents: data.hypedEvents)
            .padding()
            .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
