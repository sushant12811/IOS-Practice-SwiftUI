//
//  Constants.swift
//  HpTrivia
//
//  Created by Sushant Dhakal on 2025-01-15.
//

import Foundation
import SwiftUI

enum Constant {
    static let hpFont = "PartyLetPlain"
    static let previewQuestion = try! JSONDecoder().decode([Question].self, from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
}

struct backGroundImageView: View{
    var body: some View {
        Image("parchment")
            .resizable()
            .scaledToFill()
            .background(.brown)
    }
    
}

struct backGroundHogwartView: View{
    var body:some View {
        Image(.hogwarts)
            .resizable()
            .scaledToFill()
    }
}

extension Button {
    func doneButton() ->some View {
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .foregroundStyle(.white)
    }
}

extension FileManager {
    static var documentDirectory: URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}



