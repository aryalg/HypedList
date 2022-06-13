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
        Form {
            Section {
                TextField("Family Vacation", text: $hypedEvent.title)
                    .textInputAutocapitalization(.words)
            }
            
            Section {
                DatePicker("Date", selection: $hypedEvent.date, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
            }
            
            Section {
                ColorPicker("Color", selection: $hypedEvent.color)
            }
            
            Section {
                TextField("Website", text: $hypedEvent.url)
                    .keyboardType(.URL)
                    .textInputAutocapitalization(.never)
                    
            }
          
            
           
        }
    }
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}
