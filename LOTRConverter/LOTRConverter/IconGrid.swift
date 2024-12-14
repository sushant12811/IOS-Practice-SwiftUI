//
//  IconGrid.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-12-14.
//

import SwiftUI

struct IconGrid: View {
    
    @State  var selectedCurrency: Currency
        
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], content: {
            
            ForEach(Currency.allCases){currency in
                if (selectedCurrency == currency){
                    CurrencyIcon(currencyIcon: currency.image, currencyName: currency.name)
                        .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle(cornerRadius:25)
                            .stroke(lineWidth: 3)
                            .opacity(0.50)
                        )
                }else  {
                    CurrencyIcon(currencyIcon: currency.image, currencyName: currency.name)
                        .onTapGesture {
                            selectedCurrency = currency
                            
                        }
                    
                }
            }
           


        })    }
}

#Preview {
    IconGrid(selectedCurrency: .silverPenny)
}
