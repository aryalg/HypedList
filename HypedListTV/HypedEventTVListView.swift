//
//  HypedEventListView.swift
//  HypedListTV
//
//  Created by Bikram Aryal on 19/06/2022.
//

import SwiftUI

struct HypedEventListView: View {
    var hypedEvents: [HypedEvent]
    var noEventText:  String
    var isDiscover = false
    
    var body: some View {
        ScrollView {
        
        VStack {
            if hypedEvents.isEmpty {
            Text(noEventText)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top, 50)
                .padding(.horizontal, 10)
        } else {
            ForEach(hypedEvents) { hypedEvent in
                
               
                
                HypedEventTileView(hypedEvent: hypedEvent)
               
            }
           
        }
        }
        }.frame(minWidth: 250)
    }
}

struct HypedEventListView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventListView(hypedEvents: [testHypedEvent1], noEventText: "No Events")
    }
}
