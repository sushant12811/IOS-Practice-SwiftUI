//
//  Instruction.swift
//  HpTrivia
//
//  Created by Sushant Dhakal on 2025-01-16.
//

import SwiftUI

struct Instruction: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                backGroundImageView()
                
                VStack {
                    Image("appiconwithradius")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding(.top, 65)
                    ScrollView{
                        Text("How to Play")
                            .font(.largeTitle)
                            .padding()
                        VStack{
                            Text("Welcoe to HP Trivia! In this game , you will be asked random questions from HP books and you must guess the right answers or you will loose points! 😱")
                                .padding([.horizontal, .bottom])
                            
                            Text("Each question s worth 5 points, but if you guess a wrong answer, you loose 1 point.")
                                .padding([.horizontal, .bottom])
                            
                            Text("If you are struggling with a question, there is an option to reveal a hint or reveal the book that answer the question. But, beware ! using these also minuses the 1 point")
                                .padding([.horizontal, .bottom])
                            Text("When you select the correct the answer, you will be awarded all the points left for the question anf they will be added to your total score")
                                .padding([.horizontal, .bottom])


                               
                        }.font(.title3)
                        
                        Text("Good Luck!")
                            .font(.largeTitle)
                        
                        
                   }
                    Button("Done"){
                        dismiss()
                        
                    }.doneButton()
                        
                        
                
                
                    
                    
                }.frame(width: geo.size.width, height: geo.size.height)
                    .foregroundStyle(.black)
                
            }.frame(width: geo.size.width, height: geo.size.height)
                
               
            
            
            
        }.ignoresSafeArea()
        
        
    }
}

#Preview {
    Instruction()
}
