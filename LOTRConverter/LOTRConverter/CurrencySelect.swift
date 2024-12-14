//
//  CurrencySelect.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-12-12.
//

import SwiftUI

struct CurrencySelect: View {
    var body: some View {
        ZStack{
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], content: {
                    
                    ForEach(0..<5){_ in
                        CurrencyIcon(currencyIcon: .copperpenny, currencyText: "Copper Penny")

                    }
                   



                })
                
//                CurrencyIcon(currencyIcon: .goldpenny, currencyText: "GoldPenny")
                
                Text(
                "Select the currency you would like to conver to:"
                ).fontWeight(.bold)
                
            }.padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CurrencySelect()
}
