//
//  ContentView.swift
//  BBQuotes17
//
//  Created by Sushant Dhakal on 2024-12-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "tortoise"){
                QuoteView(show: "Breaking Bad")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                
            }
            
            Tab("Better Call Saul", systemImage: "briefcase"){
                QuoteView(show: "Better Call Saul")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
           
           
                
        }.preferredColorScheme(.dark)
    }
    }


#Preview {
    ContentView()
    
}
