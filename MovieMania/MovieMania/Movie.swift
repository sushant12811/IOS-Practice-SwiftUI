//
//  MovieData.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-10.
//
import Foundation

struct Movie: Decodable{
    var page:Int
    var results: [MovieData]
    
    
    struct MovieData: Decodable, Identifiable {
        var id: Int
        var title: String
        var overview: String
        var posterPath: String
        var popularity: Double
        var originalLanguage: String
        var releaseDate: String
        var voteAverage:Double
        var voteCount: Int
        
        // Computed property to return the full image URL
        var posterURL: URL? {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            return URL(string: baseURL + posterPath)
        }
    }
    
   
}
