//
//  PastView.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import SwiftUI

struct PastView: View {
    @ObservedObject var data = DataController.shared
    
    
    var body: some View {
        HypedEventListView(hypedEvents: data.pastHypedEvent, noEventText: "No events have passed yet, you should add some more thing!")
        

            .navigationTitle("Past")
    }
}

struct PastView_Previews: PreviewProvider {
    static var previews: some View {
        PastView()
    }
}
