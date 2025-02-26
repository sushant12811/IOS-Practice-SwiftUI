//
//  Cast.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-25.
//

import Foundation

struct Cast: Codable{
    var cast: [CastData]
    
    
    struct CastData: Codable, Identifiable{
        var id: Int
        var name : String
        var character: String
        var profilePath: String?

        var profileImage: URL? {
            guard let profilePath = profilePath else { return nil }
                        let baseURL = "https://image.tmdb.org/t/p/w500"
                        return URL(string: baseURL + profilePath)
        }
    }

}
