//
//  ApexPredatator.swift
//  ApexPredator
//
//  Created by Sushant Dhakal on 2024-12-16.
//

import Foundation
import SwiftUI

struct ApexPredator: Decodable, Identifiable{
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image : String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    
    
    enum PredatorType: String, Decodable{
        case land
        case air
        case sea
    
        var backgroundcolorType: Color {
            switch self {
            case .land:
                    .brown
            case .air:
                    .teal
            case .sea:
                    .blue
            }
        }
    }
    
}
