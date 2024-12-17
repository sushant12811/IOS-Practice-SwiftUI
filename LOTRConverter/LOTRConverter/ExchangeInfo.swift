//
//  ExchangeInfo.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-08-30.
//

import SwiftUI

struct ExchangeInfo: View {
    
    @Environment(\.dismiss) var dismissButton
    var body: some View {
        ZStack{
            //background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                Text("Exchange Rate")
                    .font(.largeTitle)
                    .tracking(3)
                
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title3)
                    .padding()
                
               
                    ExchangeRate(leftImage: .goldpiece, text: "1 Gold Piece = 4 Gold Pennies", rightImage: .goldpenny)
                    ExchangeRate(leftImage: .goldpenny, text: "1 Gold Penny = 4 Silver pieces", rightImage: .silverpiece)
                    ExchangeRate(leftImage: .silverpiece, text: "1 Silver Piece = 4 Silver Pennies", rightImage: .silverpenny)
                    ExchangeRate(leftImage: .silverpenny, text: "1 Silver Pennies = 100 Copper Pennies", rightImage: .copperpenny)
                ExchangeRate(leftImage: .copperpenny, text: "1 Copper Pennies = 100 Copper Pieces", rightImage: .copperpenny)
                   
                
                
                Button("Done"){
                    dismissButton()
                
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            
                
                }
            .foregroundStyle(.black)
            }
        }

    }


#Preview {
    ExchangeInfo()
}
