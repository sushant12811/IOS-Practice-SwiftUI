//
//  Video.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-25.
//
import Foundation
struct Video: Codable {
    var results: [VideoData]
    
    struct VideoData: Codable, Identifiable {
        let id: String
            let key: String
            let site: String
            let name: String
            let size: Int
            let type: String
            let official: Bool? 
            let publishedAt: String?
        
        var videoURL : URL? {
            if site == "YouTube"{
                return URL(string: "https://www.youtube.com/watch?v=\(key)")
            }
            return nil
        }
    }
}
