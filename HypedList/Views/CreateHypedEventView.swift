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
        
        #if os(macOS)
        bodyMac
        #else
        bodyNotMac
        #endif
        
        
    }
        
        
    
    var bodyMac: some View {
        VStack {
            VStack(alignment: .leading) {
           
            
            Section {
                FormLabelView(title: "Title", iconSystemName: "keyboard", color: .red)
                TextField("Family Vacation", text: $hypedEvent.title)
                    .padding(.bottom, 20)
                    
            }
            
            
            Section {
                FormLabelView(title: "Date", iconSystemName: "calendar", color: .blue)
                DatePicker("Date", selection: $hypedEvent.date, displayedComponents: [.date, .hourAndMinute] )
                    .padding(.bottom, 20)
                    
                
              
            }
                
            
        
            
            Section {
                FormLabelView(title: "Color", iconSystemName: "eyedropper", color: .yellow)

                                ColorPicker(selection: $hypedEvent.color) {
                                 
                }
                                .frame(maxHeight: 30)
                                .padding(.bottom, 20)
            }
            
            
            
            Section {
                FormLabelView(title: "URL", iconSystemName: "link", color: .orange)
                    
                TextField("bitpointx.com.au", text: $hypedEvent.url)
                    .padding(.bottom, 20)
                    
                    
                    
            }
          
            
           
        }
            
            .padding()
            
            Divider()
            
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }){
                    Text("Cancel")
                    
                }
                Button(action: {
                    DataController.shared.saveHypedEvent(hypedEvent: hypedEvent)
                    dismiss()
                }){
                    Text("Done")
                       
                    
                }
                .keyboardShortcut(.defaultAction)
                Spacer()
               
                
            }
        }
        .frame(minWidth: 400, minHeight: 400)
    }
        
#if !os(macOS)
    var bodyNotMac: some View {
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
                            hypedEvent.imageData =  nil
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
                        #if !os(macOS)
                    
                        ImagePicker(imageData: $hypedEvent.imageData)
                        #endif
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
            DataController.shared.saveHypedEvent(hypedEvent: hypedEvent)
            
            dismiss()
        }){
            Text("Done")
                .font(.title2)
                .bold()
            
        })
        .navigationTitle("Create")
        }
    }
    #endif
    
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
