//
//  HypedEventWatchListView.swift
//  HypedListWatch WatchKit Extension
//
//  Created by Bikram Aryal on 18/06/2022.
//

import SwiftUI

struct HypedEventWatchListView: View {
    
    var hypedEvents: [HypedEvent]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HypedEventWatchListView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventWatchListView(hypedEvents: [testHypedEvent1, testHypedEvent2])
    }
}
