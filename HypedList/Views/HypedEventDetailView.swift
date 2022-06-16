//
//  HypedEventDetailView.swift
//  HypedList
//
//  Created by Bikram Aryal on 17/06/2022.
//

import SwiftUI

struct HypedEventDetailView: View {
    
    var hypedEvent: HypedEvent
    
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
            
            
            Button(action: {}) {
                HStack {
                    Spacer()
                    Image(systemName: "link")
                    Text("Visit Site")
                    Spacer()
                }
                .font(.title2)
                .padding(12)
                .background(.orange)
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            
           
            
          

        }
    
    }
}

struct HypedEventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventDetailView(hypedEvent: testHypedEvent1)
    }
}
