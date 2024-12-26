//
//  ContentView.swift
//  BBQuotes17
//
//  Created by Sushant Dhakal on 2024-12-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
           
                Text("Breaking Bad")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Image(systemName: "tortoise.fill")
                    
                }
            
                
            Text("Better call Saul")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {Image(systemName: "briefcase.fill")
                    
                }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
    
}
