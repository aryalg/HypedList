//
//  MainView.swift
//  HypedListiOS
//
//  Created by Bikram Aryal on 17/06/2022.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        
        if(horizontalSizeClass == .compact) {
            HypedListTabView()
                
        } else {
            HypedListSidebarView()
        }
        
       
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
