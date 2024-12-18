//
//  ContentView.swift
//  ApexPredator
//
//  Created by Sushant Dhakal on 2024-12-16.
//

import SwiftUI

struct ContentView: View {
    
    let predators = Predators()
    
    var body: some View {
        List(predators.apexPredator) { predator in
            HStack{
                Image(predator.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .shadow(color:.white, radius: 1)
                
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .fontWeight(.bold)
                    Text(predator.type.rawValue.capitalized)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal,10)
                        .padding(.vertical,5)
                        .background(predator.type.backgroundcolorType)
                        .clipShape(.capsule)
                        
                }
            }

            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
