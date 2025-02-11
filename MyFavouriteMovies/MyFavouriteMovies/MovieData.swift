//
//  Movies.swift
//  MyFavouriteMovies
//
//  Created by Sushant Dhakal on 2025-01-09.
//

import Foundation
import SwiftUI


struct MovieData: Codable, Identifiable {
    let movieID: Int
    let title: String
    let studio: String
    let genres: [String]
    let directors: [String]
    let writers: [String]
    let actors: [String]
    let year: Int
    let length: Int
    let shortDescription: String
    let mpaRating: String
    let criticsRating: Double
    let imageUrl: URL

    
    
    var id: Int { movieID } // identifiable by adding var id
    
    
    //changing the background for critics rating
    func getBackgroundColor(for rating: Double) -> Color {
            if rating < 5 {
                return .red
            } else {
                return .darkGreen
            }
        }
    
  
}




