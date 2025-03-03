//
//  WatchProvider.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-26.
//
import Foundation

struct WatchProvider: Codable {
    let id: Int
    let results: [String: Region]
    
}

struct Region: Codable {
    let link: String?
    let rent: [Services]?
    let buy : [Services]?
}

struct Services:Codable{    
    let providerId: Int
    let logoPath: String?
    let providerName: String
    let displayPriority: Int
    
    var logoImage: URL? {
        guard let logoPath = logoPath else { return nil }
        let baseURL = String().baseURL()
        return URL(string: baseURL + logoPath)
    }
}


