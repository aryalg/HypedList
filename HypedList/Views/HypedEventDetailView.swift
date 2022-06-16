//
//  HypedEventDetailView.swift
//  HypedList
//
//  Created by Bikram Aryal on 17/06/2022.
//

import SwiftUI

struct HypedEventDetailView: View {
    
    var hypedEvent: HypedEvent
    var isDiscover = false
    
    var body: some View {
        VStack(spacing: 0) {
            if(hypedEvent.image() != nil) {
                hypedEvent.image()!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Rectangle().foregroundColor(hypedEvent.color)
                .frame(height: 15)
                
            HStack {
                Text(hypedEvent.title)
                    .font(.title)
                    .padding(10)
                Spacer()
            }
            
            Text("\(hypedEvent.timeFromNow().capitalized) on \(hypedEvent.dateAsString())")
                .font(.title2)
            
            Spacer()
            
            
           
            if(hypedEvent.validURL() != nil) {
                Button(action: {}) {
                HypedEventDetailViewButton(backgroundColor: .orange, imageName: "link", text: "Visit Site")
                }.padding(.bottom, 10)
                
                
            }
            
            
            if(!isDiscover) {
                Button(action: {}) {
                HypedEventDetailViewButton(backgroundColor: .red, imageName: "trash", text: "Delete")
                }
            }
            
          
            
            
            if(isDiscover) {
                Button(action: {}) {
                HypedEventDetailViewButton(backgroundColor: .blue, imageName: "plus.circle", text: "Add")
                }
            }
            
            
            if(!isDiscover) {
                Button(action: {}) {
                    HypedEventDetailViewButton(backgroundColor: .green, imageName: "pencil.circle", text: "Edit")
                }
                .padding(.bottom, 10)
                
            }
            
          
 

        }
    
    }
}

struct HypedEventDetailViewButton: View {
    
    var backgroundColor: Color
    var imageName: String
    var text: String
    
    var body: some View {
        
            HStack {
                Spacer()
                Image(systemName: imageName)
                Text(text)
                Spacer()
            }
            .font(.title2)
            .padding(12)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding(.horizontal, 20)
            .padding(.top, 10)
        
    }
}

struct HypedEventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventDetailView(hypedEvent: testHypedEvent1)
    }
}
