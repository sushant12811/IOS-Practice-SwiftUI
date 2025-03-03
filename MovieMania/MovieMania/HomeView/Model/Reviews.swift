//
//  Reviews.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-26.
//

import Foundation
struct Reviews: Codable {
    var page: Int
    var results: [Author]
}
struct Author: Codable {
    var author: String
    var authorDetails: UserInfo
    var content: String
    var createdAt: String
    var updatedAt: String?
    var id: String
    var url: String?
    
    // Custom initializer to handle missing fields
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decode(String.self, forKey: .author)
        self.authorDetails = try container.decode(UserInfo.self, forKey: .authorDetails)
        self.content = try container.decode(String.self, forKey: .content)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}

struct UserInfo: Codable {
    var name: String?
    var username: String
    var avatarPath: String?
    var rating: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.avatarPath = try container.decodeIfPresent(String.self, forKey: .avatarPath)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
    }

    
    var avatarImage : URL? {
        guard let avatarImage = avatarPath else {return URL(string: "https://www.kindpng.com/picc/m/78-786678_avatar-hd-png-download.png")}
        let baseUrl = String().baseURL()
        return URL(string: baseUrl + avatarImage)
    }
}
