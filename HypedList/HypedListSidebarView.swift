//
//  HypedListSidebarView.swift
//  HypedListiOS
//
//  Created by Bikram Aryal on 17/06/2022.
//

import SwiftUI

struct HypedListSidebarView: View {
    @State var showingCreateView = false
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: UpcomingView()) {
                    Label("Upcoming", systemImage: "calendar")
                 
                    
                }
                
                NavigationLink(destination: DiscoverView()) {
                    Label("Discover", systemImage: "magnifyingglass")
                 
                    
                }
                
                NavigationLink(destination: PastView()) {
                    Label("Past", systemImage: "gobackward")
                 
                    
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("HypedList")
            .overlay(BottomSidebarView, alignment: .bottom)
           
            
            
            UpcomingView()
            
            Text("Select an Event")
        }
    }
    
    var BottomSidebarView: some View {
        VStack {
            Divider()
            Button(action: {
                showingCreateView = true
            }) {
                Label("Create Event", systemImage: "calendar.badge.plus")
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 10)
            .foregroundColor(.blue)
            .sheet(isPresented: $showingCreateView ) {
                CreateHypedEventView()
            }
        }
    }
}

struct HypedListSidebarView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListSidebarView()
    }
}
