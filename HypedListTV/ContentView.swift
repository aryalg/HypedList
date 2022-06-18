//
//  ContentView.swift
//  HypedListTV
//
//  Created by Bikram Aryal on 19/06/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        TabView {
            HypedEventListView(hypedEvents: data.upcomingHypedEvent, noEventText: "No Upcoming Events. Please create one!")   .tabItem {
                    Image(systemName: "calendar")
                    Text("Upcoming")
                }
            HypedEventListView(hypedEvents: data.discoverHypedEvents, noEventText: "Loading Some Aweseome Stuff for ya")
          
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
            HypedEventListView(hypedEvents: data.pastHypedEvent, noEventText: "No Past Events")
                .tabItem {
                    Image(systemName: "gobackward")
                    Text("Past")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
