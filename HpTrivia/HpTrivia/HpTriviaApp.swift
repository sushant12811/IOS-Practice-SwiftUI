//
//  HpTriviaApp.swift
//  HpTrivia
//
//  Created by Sushant Dhakal on 2025-01-15.
//

import SwiftUI

@main
struct HpTriviaApp: App {
    @StateObject private var store = Store()
    @StateObject private var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(game)
                .task {
                    await store.loadProducts()
                    game.loadScore()
                    store.loadStatus()
                }
        }
    }
}
