//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-08-22.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    @State var showExchangeInfo = false
    @State var showSelectedCurrency = false
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @State var leftCurrency : Currency = .silverPiece
    @State var rightCurrency : Currency = .goldPiece
    
    let currencyTip = CurrencyTip()
    let defaults = UserDefaults.standard
    
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
                            currencyTip.invalidate(reason: .actionPerformed)
                            
                        }.popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                        
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
                            currencyTip.invalidate(reason: .actionPerformed)
                            
                        }
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                        
                    }
                }
                .padding()
                .background(.black.opacity(0.4))
                .clipShape(.capsule)
                .keyboardType(.decimalPad)
                
                
                
                
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
                    
                    
                    
                }
                .task {
                    try? Tips.configure()
                }
                .onChange(of: leftAmount){
                    if leftTyping{
                        rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                    }}
                .onChange(of: rightAmount){
                    if rightTyping{
                        leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                    }
                }
                .onChange(of: leftCurrency){
                    rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                }
                
                .onChange(of: rightCurrency){
                    leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                }
                .sheet(isPresented: $showExchangeInfo, content: {
                    ExchangeInfo()
                })
                .sheet(isPresented: $showSelectedCurrency, content: {
                    CurrencySelect(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
                })
                
                
                
            }
            
            
        }
        .onTapGesture {
            leftTyping = false // Dismisses the keyboard
            rightTyping = false
        }
        
    }
    
    
    
}



#Preview {
    ContentView()
}
