//
//  CreateHypedEventView.swift
//  HypedList
//
//  Created by Bikram Aryal on 13/06/2022.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var hypedEvent = HypedEvent()
    @State var showTime = false
    @State var showImagePicker = false
    
    
    var body: some View {
        
        NavigationView {
        
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
            
            Section {
                if hypedEvent.image() != nil {
                    HStack {
                        FormLabelView(title: "Image", iconSystemName: "camera", color: .purple)
                        Spacer()
                        Button(action: {
                            hypedEvent.imageDate =  nil
                        }) {
                            Text("Remove Image")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                } else {
                HStack {
                    FormLabelView(title: "Image", iconSystemName: "camera", color: .purple)
                    Spacer()
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text("Pick  Image")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(imageData: $hypedEvent.imageDate)
                    }
                }
                }
                
                if hypedEvent.image() != nil {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        hypedEvent.image()!.resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    
                }
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
        .navigationBarItems(leading: Button(action: {
            dismiss()
        }){
            Text("Cancel")
            
        }, trailing: Button(action: {
            DataController.shared.hypedEvents.append(hypedEvent)
            dismiss()
        }){
            Text("Done")
            
        })
        .navigationTitle("Create")
        }
    }
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}
