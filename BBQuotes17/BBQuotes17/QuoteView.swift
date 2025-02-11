//
//  QuoteView.swift
//  BBQuotes17
//
//  Created by Sushant Dhakal on 2025-01-15.
//


//
//  QuoteView.swift
//  BBQuotes17
//
//  Created by Sushant Dhakal on 2025-01-15.
//

import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    
    let show: String
    
    @State var isShowingCharacterView = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFill()
                VStack {
                    VStack {
                        Spacer(minLength: 60)
                        
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 15))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom){
                                AsyncImage(url: vm.character.images[0]){ image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                    
                                }placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                .clipShape(.rect(cornerRadius: 50))
                                
                                
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth:.infinity)
                                    .background(.ultraThinMaterial)
                                
                                
                                
                                
                            }.frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                .clipShape(.rect(cornerRadius: 50))
                                .onTapGesture{isShowingCharacterView.toggle()}
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        
                        
                        
                        Spacer()
                    }
                    Button {
                        Task{
                            await vm.getData(from: show)
                        }
                        
                    }
                        label:{
                            Text("Get Random Quote")
                                .foregroundStyle(.white)
                                .font(.title)
                                .padding()
                                .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(color:Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
                        }
                    
                    Spacer(minLength: 95)

                }
                .frame(width: geo.size.width)
                
                
            }.frame(width: geo.size.width, height:geo.size.height)
            
        }.ignoresSafeArea()
            .sheet(isPresented: $isShowingCharacterView) {
                CharacterView(character: vm.character, show: show)
            }
    }
}

#Preview {
    QuoteView(show: "Better Call Saul")
    
}
