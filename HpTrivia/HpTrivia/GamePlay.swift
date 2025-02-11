//
//  GamePlay.swift
//  HpTrivia
//
//  Created by Sushant Dhakal on 2025-01-20.
//

import SwiftUI
import AVKit

struct GamePlay: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var game: Game

    @Namespace private var namespace
    
    @State private var isAnimationOn = false
    @State private var correctAnswerTapped = false
    @State private var hintWiggle = false
    @State private var nextLevelButtonAnim = false
    @State private var moveScore = false
    @State private var revealHint = false
    @State private var revealBook = false
    @State private var tappedWrongAnswer: [Int] = []
    @State private var audioPlay: AVAudioPlayer!
    @State private var audioEffect: AVAudioPlayer!

    
    let tempAnswer = [true, false, false, false]
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                backGroundHogwartView()
                    .opacity(0.5)
                VStack {
                    
                    
                    HStack{
                        // MARK: Controller
                        Button ("End Game"){
                            game.endGameScore()
                            dismiss()
                            
                        }.buttonStyle(BorderedProminentButtonStyle())
                            .tint(.red.opacity(0.75))
                        
                        Spacer()
                        
                        
                        Text("Score:\(game.gameScore)")
                        
                    }.padding()
                        .padding(.vertical, 30)
                    
                    
                    
                    VStack{
                        VStack{
                            //MARK: Question
                            if isAnimationOn {
                                Text(game.currentQuestion.question)
                                    .font(.custom(Constant.hpFont, size: 50))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .minimumScaleFactor(80)
                                    .transition(.scale)
                                    .opacity(correctAnswerTapped ? 0.1 : 1)
                            }
                        }.animation(.easeOut(duration: isAnimationOn ? 2 : 0),  value: isAnimationOn)
                        
                        Spacer()
                        
                        HStack {
                            VStack{
                                //MARK: Hint
                                if isAnimationOn{
                                    Image(systemName: "questionmark.bubble.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                        .foregroundStyle(.cyan)
                                        .rotationEffect(.degrees( hintWiggle ? -13 : -17))
                                        .padding()
                                        .padding(.leading)
                                        .transition(.offset(x: -geo.size.width/2))
                                        .onAppear{
                                            withAnimation(.easeInOut(duration: 0.1).repeatCount(9).delay(5).repeatForever()){
                                                hintWiggle = true
                                            }
                                        }.onTapGesture {
                                            withAnimation(.easeInOut(duration:1)){
                                                revealHint = true
                                                hintBookSound()
                                                game.questionScore -= 1
                                            }
                                        }.rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x:0, y:1, z:0))
                                        .scaleEffect(revealHint ? 5 : 1)
                                        .opacity(revealHint ? 0 : 1)
                                        .offset(x: revealHint ?  geo.size.width/2 : 0)
                                        .overlay{
                                            Text(game.currentQuestion.hint)
                                                .multilineTextAlignment(.center)
                                                .minimumScaleFactor(0.5)
                                                .padding(.leading, 15)
                                                .opacity(revealHint ? 1 : 0)
                                                .scaleEffect(revealHint ? 1.33 : 1)
                                        }                                    .opacity(correctAnswerTapped ? 0.1 : 1)

                           }
                            }
                            .animation(.easeOut(duration: isAnimationOn ? 1 : 0).delay(isAnimationOn ? 1 : 0), value: isAnimationOn)
                            
                            Spacer()
                            
                            VStack{
                                
                                if isAnimationOn{
                                    Image (systemName: "book.pages")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                        .frame(width: 100, height: 100) //custom size
                                        .background(.cyan)
                                        .foregroundStyle(.black)
                                        .clipShape(.rect(cornerRadius: 25))
                                        .rotationEffect(.degrees(hintWiggle ? 13 : 17))
                                        .padding()
                                        .padding(.trailing)
                                        .transition(.offset(x: geo.size.width/2))
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 0.1).delay(5).repeatCount(9).repeatForever()){
                                                hintWiggle = true
                                            }
                                        }.onTapGesture {
                                            withAnimation(.easeOut(duration: 1)){
                                                revealBook = true
                                                hintBookSound()
                                                game.questionScore -= 1

                                            }
                                        }.rotation3DEffect(.degrees(revealBook ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                        .scaleEffect(revealBook ? 5 : 1)
                                        .offset(x: revealBook ? -geo.size.width/2 : 0)
                                        .opacity(revealBook ? 0 : 1)
                                        .overlay{
                                            Image("hp\(game.currentQuestion.book)")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(.trailing, 15)
                                                .opacity(revealBook ? 1 : 0)
                                                .scaleEffect(revealBook ? 1.33 : 1)
                                            
                                            
                                        }                                    .opacity(correctAnswerTapped ? 0.1 : 1)

                                    
                                }
                            }.animation(.easeOut(duration: isAnimationOn ? 1 : 0).delay(isAnimationOn ? 1 : 0), value: isAnimationOn)
                            
                            
                        }.padding(.bottom)
                        
                        
                        
                        LazyVGrid(columns: [GridItem(), GridItem()]){
                            ForEach(Array(game.answers.enumerated()), id: \.offset){ i, answer in
                                //MARK: Answers
                                
                                if game.currentQuestion.answers[answer] == true {

                                VStack{
                                        if isAnimationOn{
                                            if correctAnswerTapped == false {
                                                Text(answer)
                                                    .font(.title2)
                                                    .minimumScaleFactor(0.5)
                                                    .frame(width: geo.size.width/2.5, height: geo.size.height/12)
                                                    .background(Color.green.opacity(0.5))
                                                    .clipShape(.rect(cornerRadius: 20))
                                                    .transition(.asymmetric(insertion: .scale, removal: .scale(scale:4).combined(with: .opacity.animation(.easeOut(duration: 0.5)))))
                                                    .matchedGeometryEffect(id: "answer", in: namespace)
                                                    .onTapGesture {
                                                        withAnimation(.easeOut(duration:1)){
                                                            correctAnswerTapped = true
                                                            soundCorrect()
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5 ){
                                                                game.correct()
                                                            }
                                                           
                                                        }
                                                    }                                  .opacity(correctAnswerTapped ? 0.1 : 1)

                                            }
                                        }
                                }.animation(.easeOut(duration: isAnimationOn ? 2 : 0), value: isAnimationOn)
                                }else{
                                    
                                    VStack{
                                            if isAnimationOn{
                                                Text(answer)
                                                    .font(.title2)
                                                    .minimumScaleFactor(0.5)
                                                    .frame(width: geo.size.width/2.5, height: geo.size.height/12)
                                                    .background(tappedWrongAnswer.contains(i) ? .red.opacity(0.5) : .green.opacity(0.5))
                                                    .clipShape(.rect(cornerRadius: 20))
                                                    .transition(.scale)
                                                    .onTapGesture{
                                                        withAnimation(.easeOut(duration:1)){
                                                            
                                                            tappedWrongAnswer.append(i)
                                                            soundWrong()
                                                            wrongAnswerFeedBack()
                                                            game.questionScore -= 1

                                                            
                                                        }
                                                    }.scaleEffect(tappedWrongAnswer.contains(i) ? 0.8 : 1)
                                                    .disabled(tappedWrongAnswer.contains(i) || correctAnswerTapped)
                                                    .opacity(correctAnswerTapped ? 0.1 : 1)

                                                   
                                            }
                                    }.animation(.easeOut(duration: isAnimationOn ? 2 : 0), value: isAnimationOn)
                                    
                                }

                                
                            }
                            
                        }
                        
                        Spacer()
                        
                    }
                }.foregroundStyle(.white)
                    .frame(width: geo.size.width, height: geo.size.height)
                
                
                //MARK: Celebration screen
                VStack{
                    
                    Spacer()
                    VStack{
                        if correctAnswerTapped{
                            Text("\(game.questionScore)")
                                .font(.title)
                                .padding(.vertical,20)
                                .transition(.offset(y: -geo.size.height/2))
                                .offset(x: moveScore ? geo.size.width/2.15 : 0, y: moveScore ? -geo.size.height/10 : 0)
                                .opacity(moveScore ? 0 : 1)
                                
                                .onAppear{
                                    withAnimation(.easeInOut(duration: 1).delay(3)){
                                        moveScore = true
                                    }
                                }
                        }
                    }.animation(.easeInOut(duration: correctAnswerTapped ? 1.5 : 0).delay(correctAnswerTapped ? 1.5 : 0), value: correctAnswerTapped)
                    VStack{
                        if correctAnswerTapped{
                            Text("Brilliant!")
                                .font(.custom(Constant.hpFont, size: 100))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height/2)))
                        }
                    }.animation(.easeInOut(duration: correctAnswerTapped ? 1.5 : 0).delay(correctAnswerTapped ? 1.5 : 0), value: correctAnswerTapped)
                    
                    Spacer()
                    
                    if correctAnswerTapped{
                        Text(game.correctAnswer)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .frame(width: geo.size.width/2.15, height: geo.size.height/12)
                            .background(.green.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 20))
                            .scaleEffect(2)
                            .matchedGeometryEffect(id: "answer", in: namespace)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    VStack{
                        if correctAnswerTapped{
                            Button("Next Level >"){
                                
                                //TODO: Reset level
                                isAnimationOn = false
                                correctAnswerTapped = false
                                nextLevelButtonAnim = false
                                game.newQuestion()
                          
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    isAnimationOn = true
                                   
                                }
                                
                            }
                            .buttonStyle(.borderedProminent)
                            .font(.largeTitle)
                            .padding(10)
                            .tint(.blue.opacity(0.7))
                            .transition(.offset(y: geo.size.height/3))
                            .scaleEffect(nextLevelButtonAnim ? 1 : 1.2)
                            .onAppear{
                                withAnimation(.easeInOut(duration: 1.3 ).repeatForever()){
                                    nextLevelButtonAnim.toggle()
                                }
                                
                            }
                        }
                    }.animation(.easeInOut(duration: correctAnswerTapped ? 2.5 : 0).delay(correctAnswerTapped ? 2.5 : 0), value: correctAnswerTapped)
                    
                    Spacer()
                    Spacer()
                    
                }
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .preferredColorScheme(.dark)
        }
        .ignoresSafeArea()
            .onAppear{
                isAnimationOn = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    audioBackPlayer()
                }
            }
    }
    
    func audioBackPlayer (){
        
        let allSound = ["deep-in-the-dell", "hiding-place-in-the-forest", "let-the-mystery-unfold", "magic-in-the-air"]
        
        let randomSound = allSound.randomElement()
            
        let sound = Bundle.main.path (forResource: randomSound, ofType: ".mp3")
            audioPlay = try! AVAudioPlayer(contentsOf: URL(filePath: sound ?? "error"))
            audioPlay.volume = 0.1
            audioPlay.numberOfLoops = -1
            audioPlay.play()
    }
    
    func soundCorrect (){
        let sound = Bundle.main.path (forResource: "magic-wand", ofType: ".mp3")
        audioEffect = try! AVAudioPlayer(contentsOf: URL(filePath: sound ?? "error"))
        audioEffect.play()
        
    }
    
    func soundWrong (){
        let sound = Bundle.main.path (forResource: "negative-beeps", ofType: ".mp3")
        audioEffect = try! AVAudioPlayer(contentsOf: URL(filePath: sound ?? "error"))
        audioEffect.play()
        
    }
    
    func hintBookSound(){
        let sound = Bundle.main.path (forResource: "page-flip", ofType: ".mp3")
        audioEffect = try! AVAudioPlayer(contentsOf: URL(filePath: sound ?? "error"))
        audioEffect.play()
        
    }
    
    func wrongAnswerFeedBack (){
        let generate = UINotificationFeedbackGenerator()
        generate.notificationOccurred(.error)
    }
   
}

#Preview {
    VStack {
        GamePlay()
            .environmentObject(Game())
    }
}
