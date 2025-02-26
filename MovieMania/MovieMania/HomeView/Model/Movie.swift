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
                        let baseURL = "https://image.tmdb.org/t/p/w500"
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
        
//        init(movieId: Int, movieTitle: String, movieOverview: String, moviePosterPath: String,
//                     moviePopularity: Double, movieLanguage: String, movieReleaseDate: String,
//                     movieVoteAverage: Double, movieVoteCount: Int, movieGenreIds: [Int]) {
//                    self.id = movieId
//                    self.title = movieTitle
//                    self.overview = movieOverview
//                    self.posterPath = moviePosterPath
//                    self.popularity = moviePopularity
//                    self.originalLanguage = movieLanguage
//                    self.releaseDate = movieReleaseDate
//                    self.voteAverage = movieVoteAverage
//                    self.voteCount = movieVoteCount
//                    self.genreIds = movieGenreIds
//                }
//            }
    }
    
    
    
   




