//
//  ExchangeRate.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-12-12.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage:ImageResource
    let text: String
    let rightImage: ImageResource
    
    
    var body: some View {
        
        HStack{
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            Text(text)
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpenny, text: "1 goldpenny = 4 gold pieces", rightImage: .goldpiece)
}
