//
//  DiscoverView.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import SwiftUI

struct DiscoverView: View {
    
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        HypedEventListView(hypedEvents: data.discoverHypedEvents.sorted { $0.date < $1.date}, noEventText: "Loading awesome stuff for ya!", isDiscover: true)
        

            .navigationTitle("Discover")
            .toolbar {
                Button {
                    data.getDiscoverEvents()
                    
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.title)
                }
                

            }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
