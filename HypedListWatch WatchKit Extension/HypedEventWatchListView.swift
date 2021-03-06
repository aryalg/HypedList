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
        if(hypedEvents.count > 0) {
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(hypedEvents) {hypedEvent in
                        HStack {
                            Spacer()
                           
                        VStack {
                            
                        Text(hypedEvent.title)
                                .font(.headline)
                               
                            
                            
                        Text("\(hypedEvent.timeFromNow().capitalized) on \(hypedEvent.dateAsString())")
                            
                        }
                        .foregroundColor(hypedEvent.color.isDarkColor ? .white : .black)
                        .multilineTextAlignment(.center)
                            
                        .padding(.horizontal, 5)
                            Spacer()
                        
                          
                        }.background(hypedEvent.color)
                            .cornerRadius(5)
                    }
                }
            }
            
        } else {
        Text("No Upcoming Events\nCreate Event from Phone")
                .multilineTextAlignment(.center)
        }
    }
}

struct HypedEventWatchListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HypedEventWatchListView(hypedEvents: [testHypedEvent1, testHypedEvent2])
            
            HypedEventWatchListView(hypedEvents: [])
        }
    }
}

extension Color {
    var isDarkColor: Bool {
        var r,g,b,a: CGFloat
        (r,g,b,a) = (0,0,0,0)
        
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * a
        return lum < 0.6
        
    }
}
