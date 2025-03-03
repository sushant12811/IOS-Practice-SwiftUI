//
//  Actor.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-28.
//

import Foundation

struct Actor: Codable, Identifiable, Hashable {
    let id: Int
    let adult: Bool
    let alsoKnownAs: [String]?
    let biography: String
    let birthday: String?
    let deathday: String?
    let gender: Int
    let homepage: String?
    let knownForDepartment: String
    let imdbId: String
    let name: String
    let placeOfBirth: String?
    let profilePath: String?

    // Computed property for profile image URL
    var profileImage: URL? {
        if let profilePath = profilePath {
            return URL(string: "\(String().baseURL())\(profilePath)")
        } else {
            return URL(string: "https://www.kindpng.com/picc/m/78-786678_avatar-hd-png-download.png")
        }
    }

    var genderId : String{
        let genderName: [Int : String] = [
            0 : "Not Set/ Not Specified",
            1 : "Female",
            2 : "Male",
            3 : "Non-binary"
        ]
        
        return genderName[gender] ?? "Unknown"
    }
    // Explicit initializer to support mock data
    init(
        id: Int,
        adult: Bool,
        alsoKnownAs: [String]?,
        biography: String,
        birthday: String?,
        deathday: String?,
        gender: Int,
        homepage: String?,
        knownForDepartment: String,
        imdbId: String,
        name: String,
        placeOfBirth: String?,
        profilePath: String?
    ) {
        self.id = id
        self.adult = adult
        self.alsoKnownAs = alsoKnownAs
        self.biography = biography
        self.birthday = birthday
        self.deathday = deathday
        self.gender = gender
        self.homepage = homepage
        self.knownForDepartment = knownForDepartment
        self.imdbId = imdbId
        self.name = name
        self.placeOfBirth = placeOfBirth
        self.profilePath = profilePath
    }

    // Custom decoder initializer for Decodable
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.alsoKnownAs = try container.decodeIfPresent([String].self, forKey: .alsoKnownAs)
        self.biography = try container.decode(String.self, forKey: .biography)
        self.birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        self.deathday = try container.decodeIfPresent(String.self, forKey: .deathday)
        self.gender = try container.decode(Int.self, forKey: .gender)
        self.homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        self.knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        self.imdbId = try container.decode(String.self, forKey: .imdbId)
        self.name = try container.decode(String.self, forKey: .name)
        self.placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth)
        self.profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
    }

    // Mock Data
    static let mockData = Actor(
        id: 1190668,
        adult: false,
        alsoKnownAs: [
            "蒂莫西·查拉梅",
            "ティム",
            "ティミー",
            "ティモテ・シャラメ",
            "Timotijs Šalame",
            "Timothée Hal Chalamet"
        ],
        biography: """
        Timothée Hal Chalamet (born December 27, 1995) is an American actor. 
        He began his career appearing in the drama series Homeland in 2012. 
        Two years later, he made his film debut in the comedy-drama Men, Women & Children and appeared in 
        Christopher Nolan's science fiction film Interstellar. He came into attention in Luca Guadagnino's 
        coming-of-age film Call Me by Your Name (2017). Alongside supporting roles in Greta Gerwig's films 
        Lady Bird (2017) and Little Women (2019), he took on starring roles in Beautiful Boy (2018) and Dune (2021).
        """,
        birthday: "1995-12-27",
        deathday: nil,
        gender: 2,
        homepage: nil,
        knownForDepartment: "Acting",
        imdbId: "nm3154303",
        name: "Timothée Chalamet",
        placeOfBirth: "Manhattan, New York City, New York, USA",
        profilePath: "/BE2sdjpgsa2rNTFa66f7upkaOP.jpg"
    )
}
