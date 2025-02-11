//
//  ContentView.swift
//  HpTrivia
//
//  Created by Sushant Dhakal on 2025-01-15.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @EnvironmentObject private var store:Store
    @EnvironmentObject private var game:Game
    
    @State private var scaleToPlayButton = false
    @State private var backgroundMotion = false
    @State private var audioPlay: AVAudioPlayer!
    @State private var transitView = false
    @State private var isShowingInfo = false
    @State private var isShowingSetting = false
    @State private var isShowingGamePlay = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                backGroundHogwartView()
                    .offset(x: backgroundMotion ? geo.size.width/1.1 : -geo.size.width/1.1)
                    .onAppear{
                        withAnimation(.linear(duration: 60).repeatForever()){
                            backgroundMotion.toggle()
                        }
                    }
                
                VStack{
                    VStack{
                        if transitView{
                            VStack{
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                
                                Text("HP")
                                    .font(.custom(Constant.hpFont, size: 70))
                                    .padding(.bottom, -50)
                                Text("Trivia")
                                    .font(.custom(Constant.hpFont, size: 60))
                            }
                            .padding(.top,60)
                            .transition(.offset(y: -geo.size.height/3))
                            
                        }
                    }.animation(.easeOut(duration: 0.7).delay(2), value: transitView)
                    
                    Spacer()
                    
                    VStack{
                        Text("Recent Scores:")
                            .font(.title2)
                        
                        Text("\(game.recentScores[0])")
                        Text("\(game.recentScores[1])")
                        Text("\(game.recentScores[2])")
                        
                        
                    }.font(.title3)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 15))
                    
                    Spacer()
                    HStack{
                        
                        VStack{
                            if transitView {
                                Button{
                                    
                                    isShowingInfo.toggle()
                                    
                                }label:{
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 3)
                                    
                                }.transition(.offset(x: -geo.size.width/3))
                                    .sheet(isPresented: $isShowingInfo)  {
                                        Instruction()
                                    }
                            }
                        }.animation(.easeOut(duration: 0.7).delay(2.7), value: transitView)
                        
                        
                        
                        Spacer()
                        
                        VStack{
                            if transitView {
                                Button{
                                    filteredQuestions()
                                    game.startGame()
                                    isShowingGamePlay.toggle()
                                    
                                }label:{
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 50)
                                        .padding(.vertical,8)
                                        .background(store.book.contains(.active) ? .brown : .gray)
                                        .clipShape(.rect(cornerRadius: 8))
                                    
                                }
                                .fullScreenCover(isPresented: $isShowingGamePlay, content: {
                                    GamePlay()
                                        .environmentObject(game)
                                        .onAppear{
                                            audioPlay.setVolume(0, fadeDuration: 2)
                                        }.onDisappear{
                                            audioPlay.setVolume(1, fadeDuration: 3)
                                        }
                                })
                                .disabled(store.book.contains(.active) ? false : true)
                                .scaleEffect(scaleToPlayButton ? 1.2 : 1)
                                .onAppear{
                                    withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                        scaleToPlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y: geo.size.height/2))
                                
                            }
                        }.animation(.easeOut(duration: 0.7).delay(2), value: transitView)
                        
                        
                        Spacer()
                        
                        VStack{
                            if transitView {
                                Button{
                                    isShowingSetting.toggle()
                                    
                                }label:{
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.white)
                                    
                                }
                                .transition(.offset(x: geo.size.width/3))
                                .sheet(isPresented: $isShowingSetting) {
                                    Setting()
                                        .environmentObject(store)
                                }
                            }
                        }.animation(.easeOut(duration: 0.7).delay(2.7), value: transitView)
                    }.frame(width: geo.size.width/1.1)
                    
                    Spacer()
                    
                    VStack{
                        if transitView{
                            Text("No Questions available. Please go to the Setting ⬆️ ")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .transition(.opacity)
                            
                        }
                        
                    }
                    
                    .animation(.easeOut.delay(3), value: transitView)
                        
                    
                    Spacer()
                }
                
                
            }
            .foregroundStyle(.black)
            .frame(width: geo.size.width, height: geo.size.height)
                .padding(.top,2)

        }
        .ignoresSafeArea()
        
            .onAppear{
                playAudio()
                transitView = true
            }
        
        
    }
    
    private func playAudio (){
        let sound = Bundle.main.path (forResource: "magic-in-the-air", ofType: ".mp3")
        audioPlay = try! AVAudioPlayer(contentsOf: URL(filePath: sound ?? "error"))
        audioPlay.numberOfLoops = -1
        audioPlay.play()
    }
    
    private func filteredQuestions(){
        var books: [Int] = []
        for (index, status) in store.book.enumerated(){
            if status == .active {
                books.append(index + 1)
            }
        }
        
        game.filteredQuestions(to: books)
        game.newQuestion()
    }
}

#Preview {
    VStack {
        ContentView()
            .environmentObject(Store())
            .environmentObject(Game())
    }
}
