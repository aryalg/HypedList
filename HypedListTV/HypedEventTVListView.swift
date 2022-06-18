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
        
        if hypedEvents.isEmpty {
        Text(noEventText)
            .bold()
            .multilineTextAlignment(.center)
            .padding(.top, 50)
            .padding(.horizontal, 10)
        } else {
        ScrollView(.horizontal) {
            
            
        
        HStack {
            
            ForEach(hypedEvents) { hypedEvent in
                
                Button(action:{}) {
                
                HypedEventTVTileView(hypedEvent: hypedEvent)
                }
                .buttonStyle(PlainButtonStyle())
                .contextMenu {
                    if isDiscover {
                        Button(action: {
                            DataController.shared.addFromDiscover(hypedEvent: hypedEvent)
                        }) {
                            Text("Add")
                        }
                    } else {
                    Button(action: {
                        DataController.shared.deleteHypedEvent(hypedEvent: hypedEvent)
                    }) {
                        Text("Delete")
                    }
                    }
                }
            }
           
        }
        
        }.frame(minWidth: 250)
        }
    }
}

struct HypedEventListView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventListView(hypedEvents: [testHypedEvent1, testHypedEvent2], noEventText: "No Events")
    }
}
