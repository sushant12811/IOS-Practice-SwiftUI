//
//  MovieData.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-10.
//
import Foundation

struct Movie: Codable{
    var page:Int
    var results: [MovieData]
    
    
    struct MovieData: Codable, Identifiable {
        var id: Int
        var title: String
        var overview: String
        var posterPath: String?
        var popularity: Double
        var originalLanguage: String
        var releaseDate: String
        var voteAverage:Double
        var voteCount: Int
        var genreIds:[Int]
        
        
        
        // Computed property to return the full image URL
        var posterURL: URL? {
            guard let posterURL = posterPath else { return nil }
            let baseURL = String().baseURL()
            return URL(string: baseURL + posterURL)
        }
        
        var genreNames: [String] {
            let genreMap: [Int: String] = [
                28: "Action",
                12: "Adventure",
                16: "Animation",
                35: "Comedy",
                80: "Crime",
                99: "Documentary",
                18: "Drama",
                10751: "Family",
                14: "Fantasy",
                36: "History",
                27: "Horror",
                10402: "Music",
                9648: "Mystery",
                10749: "Romance",
                878: "Science Fiction",
                10770: "TV Movie",
                53: "Thriller",
                10752: "War",
                37: "Western"
            ]
            return genreIds.compactMap { genreMap[$0] }
            
        }
            
                }
    
    static let mockData = MovieData(
                id: 123,
                title: "Inception",
                overview: "A mind-bending thriller about dreams within dreams.",
                popularity: 95.0,
                originalLanguage: "en",
                releaseDate: "2010-07-16",
                voteAverage: 8.8,
                voteCount: 10000,
                genreIds: [28, 878, 12]
            )
        
    
    }
    
    
    
   




