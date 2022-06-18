//
//  HypedEventTVTileView.swift
//  HypedListTV
//
//  Created by Bikram Aryal on 19/06/2022.
//

import SwiftUI

struct HypedEventTVTileView: View {
    var isDiscover = false
    
    
   @ObservedObject var hypedEvent: HypedEvent
    
    var body: some View {
        VStack(spacing: 0) {
            if(hypedEvent.image() != nil) {
                HStack {
                    Spacer()
                hypedEvent.image()!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    Spacer()
                }.background(hypedEvent.color)
            } else {
               hypedEvent.color
                    .aspectRatio(contentMode: .fit)
            }
            
            
                
       
                Text(hypedEvent.title)
                .font(.largeTitle)
                .padding(.top, 10)
                .foregroundColor(.black)
                  
             
//            .background(.white)
            
            
            Text("\(hypedEvent.timeFromNow().capitalized) on \(hypedEvent.dateAsString())")
                .font(.title)
                .padding(.bottom, 10)
                .foregroundColor(.black)
            
            
        }
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 10)

    }
}

struct HypedEventTVTileView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventTVTileView(hypedEvent: testHypedEvent1)
    }
}
