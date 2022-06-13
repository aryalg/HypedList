//
//  UpcomingView.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    
    
    
    var body: some View {
        Text("Upcoming View")
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
        NavigationView {
            UpcomingView()
        }
        
    }
}
