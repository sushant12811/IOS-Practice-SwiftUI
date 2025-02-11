//
//  Setting.swift
//  HpTrivia
//
//  Created by Sushant Dhakal on 2025-01-20.
//

import SwiftUI



struct Setting: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: Store
    
    
    var body: some View {
        GeometryReader{ geo in
            
            
            ZStack{
                backGroundImageView()
                
                VStack {
                    Text("Which book would you like to see question from?")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    ScrollView{
                        LazyVGrid(columns:[GridItem(), GridItem()]){
                            ForEach (0..<7){i in
                                if store.book[i] == .active || (store.book[i] == .locked && store.purchasedIDs.contains("hp\(i+1)") ){
                                    ZStack (alignment:.bottomTrailing){
                                        Image("hp\(i+1)")
                                            .resizable()
                                            .scaledToFit()
                                            .shadow(radius: 7)
                                        
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.largeTitle)
                                            .foregroundStyle(.green)
                                            .shadow(radius: 1)
                                            .padding(3)
                                            
                                            .onTapGesture {
                                                store.book[i] = .inactive
                                                store.saveStatus()
                                            }.task{
                                                store.book[i] = .active
                                                store.saveStatus()
                                            }
                                    }
                                }
                                else if store.book[i] == .inactive{
                                    ZStack(alignment:.bottomTrailing){
                                        Image("hp\(i+1)")
                                            .resizable()
                                            .scaledToFit()
                                            .shadow(radius: 7)
                                            .overlay (Rectangle().opacity(0.40))
                                        Image(systemName: "circle")
                                            .font(.largeTitle)
                                            .foregroundStyle(.green.opacity(0.75))
                                            .shadow(radius: 1)
                                            .padding(3)
                                            .onTapGesture {
                                                store.book[i] = .active
                                                store.saveStatus()
                                            }
                                    }
                                    
                                    
                                }else{
                                    ZStack(alignment:.center){
                                        Image("hp\(i+1)")
                                            .resizable()
                                            .scaledToFit()
                                            .shadow(radius: 7)
                                            .overlay (Rectangle().opacity(0.75))
                                        Image(systemName: "lock.fill")
                                            .font(.largeTitle)
                                            .shadow(color:.white.opacity(0.75), radius: 3)
                                            .padding(3)
                                            .onTapGesture {
                                                let products = store.products[i-3]
                                                Task {
                                                    await store.purchased(products)
                                                }
                                            }
                                        
                                        
                                    }
                                    
                                }
                            }
                            
                        }.padding()
                    }
                    
                    Button("Done"){
                        dismiss()
                        
                    }.doneButton()
                }.foregroundStyle(.black)
                    .frame(width: geo.size.width, height: geo.size.height)
                
                
                
                
                
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    Setting()
        .environmentObject(Store())
}
