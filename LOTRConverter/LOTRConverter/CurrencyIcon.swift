//
//  CurrencyIcon.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-12-12.
//

import SwiftUI

struct CurrencyIcon: View {
    
    let currencyIcon : ImageResource
    let currencyText: String
    
    var body: some View {
        
       
        ZStack(alignment: .bottom) {
        
                Image(currencyIcon)
                .resizable()
                .scaledToFit()
            
                Text(currencyText)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .background(.brown.opacity(0.75))
           
            
        }.padding(3)
        .frame(width: 100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
        
            
            
           
        }
    }


#Preview {
    CurrencyIcon(currencyIcon: .copperpenny, currencyText: "copperPenny")
}
