//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-08-22.
//

import SwiftUI

struct ContentView: View {
    
    @State var showExchangeInfo = false
    @State var showSelectedCurrency = false
    
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @State var leftCurrency : Currency = .silverPiece
    @State var rightCurrency : Currency = .goldPiece
    
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                HStack{
                    VStack{
                        HStack{
                            
                            //Left Amount
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 35)
                            
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.bottom,-5)
                        }.onTapGesture {
                            showSelectedCurrency.toggle()
                        }
                        
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                        
                        
                    }
                    
                    //Right Amount
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    VStack{
                        HStack{
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.bottom,-5)

                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 35)
                            
                        }.onTapGesture {
                            showSelectedCurrency.toggle()
                        }
                        
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding()
                .background(.black.opacity(0.4))
                .clipShape(.capsule)
                .sheet(isPresented: $showSelectedCurrency, content: {
                    
                    CurrencySelect(topCurrency: leftCurrency, bottomCurrency: rightCurrency)
                })

                
                
                Spacer()
                
                HStack {
                    
                    Spacer() //spacing the info button to the right
                    Button{
                        showExchangeInfo.toggle()
                        
                    }label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                }
                    .padding(.trailing)
                    .sheet(isPresented: $showExchangeInfo, content: {
                        ExchangeInfo()
                    }
                           )
                }
                
                
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
