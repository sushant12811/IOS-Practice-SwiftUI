//
//  CurrencySelect.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-12-12.
//

import SwiftUI

struct CurrencySelect: View {
    
    @Environment(\.dismiss) var dismissButton

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
                    
                    ForEach(Currency.allCases){currency in
                        CurrencyIcon(currencyIcon: currency.image, currencyText: currency.text)

                    }
                   


                })
                
                
                Text(
                "Select the currency you would like to conver to:"
                ).fontWeight(.bold)
                
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], content: {
                    
                    ForEach(Currency.allCases){currency in
                        CurrencyIcon(currencyIcon: currency.image, currencyText: currency.text)

                    }
                   


                })
                
                Button("Done"){
                    dismissButton()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                
            }.padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CurrencySelect()
}
