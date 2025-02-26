//
//  UserDetails.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-18.
//

import Foundation

struct UserDetails: Identifiable, Hashable, Decodable{
    let uid: String
    let username: String
    let email: String
    var profileImageUrl: String? = nil
    
    var id: String{
        return uid
    }
    
}

extension UserDetails {
    init(dictionary: [String : Any]){
        self.uid = dictionary[.uid] as? String ?? ""
        self.username = dictionary[.username] as? String ?? ""
        self.email = dictionary[.email] as? String ?? ""
        self.profileImageUrl = dictionary[.profileImageUrl] as? String? ?? nil
        
    }
    
    static let previewPlaceholder = UserDetails(uid: "1", username: "abc123", email: "abc@gmail.com")
}

extension String {
    static let uid = "uid"
    static let username = "username"
    static let email = "email"
    static let profileImageUrl = "profileImageUrl"
    
}


