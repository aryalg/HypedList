//
//  CreateHypedEventView.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @StateObject var hypedEvent = HypedEvent()
    
    
    var body: some View {
        Text("Create Hyped Event")
    }
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}
