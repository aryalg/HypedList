//
//  HypedEventListView.swift
//  HypedList
//
//  Created by Bikram Aryal on 17/06/2022.
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
                
                NavigationLink(destination: HypedEventDetailView(hypedEvent: hypedEvent, isDiscover: isDiscover)) {
                
                HypedEventTileView(hypedEvent: hypedEvent)
                }
                .buttonStyle(PlainButtonStyle())
            }
           
        }
        }
        }.frame(minWidth: 250)
    }
}

struct HypedEventListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HypedEventListView(hypedEvents: [testHypedEvent1, testHypedEvent2], noEventText: "Nothing here :(")
            }

            NavigationView {
                HypedEventListView(hypedEvents: [], noEventText: "Nothing here :(")
            }
        }
    }
}
