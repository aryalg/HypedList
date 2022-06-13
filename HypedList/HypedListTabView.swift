//
//  HypedListTabView.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import SwiftUI

struct HypedListTabView: View {
    var body: some View {
        TabView {
            Text("Hello1")
                .tabItem {
                    Text("Upcoming")
                }
            Text("Hello2")
                .tabItem {
                    Text("Discover")
                }
            Text("Hello3")
                .tabItem {
                    Text("Past")
                }
        }
    }
}

struct HypedListTabView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListTabView()
            .previewDevice("iPhone 13 Pro")
    }
}
