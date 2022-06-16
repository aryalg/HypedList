//
//  UpcomingView.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    var hypedEvents: [HypedEvent] = []
    
    
    
    
    var body: some View {
        
        ScrollView {
        
        VStack {
        if hypedEvents.isEmpty {
            Text("Nothing to look forward to 😥\nCreate an event or check out the Discover tab!")
                .bold()
                .multilineTextAlignment(.center)
                .padding()
        } else {
            ForEach(hypedEvents) { hypedEvent in
                
                Text(hypedEvent.title)
            
            }
           
        }
        }
        }
        

            .navigationTitle("Upcoming")
            .toolbar {
                Button {
                    showingCreateView = true
                    
                } label: {
                    Image(systemName: "calendar.badge.plus")
                        .font(.title)
                }
                .sheet(isPresented: $showingCreateView) {
                    CreateHypedEventView()
                    
                }

            }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            NavigationView {
                UpcomingView(hypedEvents: [testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,testHypedEvent1, testHypedEvent2,])
            }
            
            NavigationView {
                UpcomingView(hypedEvents: [])
            }
        }
      
    }
}
