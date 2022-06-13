//
//  CreateHypedEventView.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @StateObject var hypedEvent = HypedEvent()
    @State var showTime = false
    @State var showImagePicker = false
    
    
    var body: some View {
        Form {
            Section {
                FormLabelView(title: "Title", iconSystemName: "keyboard", color: .red)
                TextField("Family Vacation", text: $hypedEvent.title)
                    .textInputAutocapitalization(.words)
            }
            
            Section {
                FormLabelView(title: "Date", iconSystemName: "calendar", color: .blue)
                DatePicker("Date", selection: $hypedEvent.date, displayedComponents: showTime ? [.date, .hourAndMinute] : [.date])
                    .datePickerStyle(.graphical)
                
                Toggle(isOn: $showTime) {
                    FormLabelView(title: "Time", iconSystemName: "clock.fill", color: .blue)
                }
            }
            
            Button(action: {
                showImagePicker = true
            }) {
                Text("Pick  Image")
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker()
            }
            
            Section {
                                ColorPicker(selection: $hypedEvent.color) {
                                    FormLabelView(title: "Color", iconSystemName: "eyedropper", color: .yellow)

                }
            }
            
            
            
            Section {
                FormLabelView(title: "URL", iconSystemName: "link", color: .orange)
                TextField("bitpointx.com.au", text: $hypedEvent.url)
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
