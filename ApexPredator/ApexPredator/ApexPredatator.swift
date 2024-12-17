//
//  ApexPredatator.swift
//  ApexPredator
//
//  Created by Sushant Dhakal on 2024-12-16.
//

import Foundation

struct ApexPredatator: Decodable{
    let id: Int
    let name: String
    let type: String
    let latitude: String
    let longitude: String
    let movies: [String]
    let movieScene: [MovieScene]
    let link: String
    
    struct MovieScene: Decodable{
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
}
