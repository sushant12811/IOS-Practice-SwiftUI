//
//  Game.swift
//  HpTrivia
//
//  Created by Sushant Dhakal on 2025-01-22.
//

import Foundation
import SwiftUI

@MainActor
class Game: ObservableObject {
    @Published var gameScore = 0
    @Published var questionScore = 5
    @Published var recentScores = [0, 0, 0]
   
    private var allQuestions:[Question] = []
    private var answeredQuestions:[Int] = []
    private let savepath = FileManager.documentDirectory.appending(path: "saveScore")
    
     var filterQuestion:[Question] = []
     var currentQuestion = Constant.previewQuestion
     var answers:[String] = []
    
    
    var correctAnswer :String {
        currentQuestion.answers.first(where: {$0.value == true})!.key
    }
    
    init(){
        decodeQuestions()
    }
    
    func startGame (){
        gameScore = 0
        questionScore = 5
        answeredQuestions = []
    }
    
    func filteredQuestions(to books: [Int]){
        filterQuestion = allQuestions.filter{books.contains($0.book)}
        
    }
    
    func newQuestion(){
        if filterQuestion.isEmpty {
            return
        }
        
        if answeredQuestions.count == filterQuestion.count {
            answeredQuestions = []
        }
        
        var potentialQuestion = filterQuestion.randomElement()!
        
        while answeredQuestions.contains(potentialQuestion.id){
            potentialQuestion = filterQuestion.randomElement()!
            

        }
        
        currentQuestion = potentialQuestion
        
        
        answers = []
        
        for answer in currentQuestion.answers.keys {
            answers.append(answer)
        }
        
        answers.shuffle()

        questionScore = 5

    }
    
    func correct(){
        answeredQuestions.append(currentQuestion.id)
        
        withAnimation{
            gameScore += questionScore
        }
    }
    
    
    func endGameScore(){
        recentScores[2] = recentScores[1]
        recentScores [1] = recentScores[0]
        recentScores [0] = gameScore
        saveScores()
    }
    
    func loadScore(){
        do{
            let data = try Data(contentsOf: savepath)
            recentScores = try JSONDecoder().decode([Int].self, from: data)
        }catch{
            recentScores = [0, 0 ,0]
        }
    }
    
    
    private func saveScores(){
        do{
            let data = try JSONEncoder().encode(recentScores)
            try data.write(to: savepath)
            
        }catch{
            print("unable to save score\(error)")
        }
    }
    
    private func decodeQuestions(){
        if let url = Bundle.main.url(forResource: "trivia", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allQuestions = try decoder.decode([Question].self, from: data)
                filterQuestion = allQuestions
                
            }catch{
                print("Error decoding:\(error)")
            }
        }
    }
}
