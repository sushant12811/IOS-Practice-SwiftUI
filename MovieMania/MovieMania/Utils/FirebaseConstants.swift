//
//  FirebaseConstants.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-18.
//
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import SwiftUI


enum FirebaseConstants {
    private static let DatabaseRef = Database.database().reference()
    static let user = DatabaseRef.child("users")
    static let db = Firestore.firestore()

    
}

enum CollectionNames{
    case favourite, wishedList, watched
   
    var dataName: String{
        switch self {
        case .favourite:
            "favourite_collection"
        case .wishedList:
            "wish_collection"
        case .watched:
            "already_watched"
        }
    }
}

//Verical Line
func verticalLine()-> some View {
    VStack{
        
    }.frame(width: 1, height: 25)
        .background(.gray.opacity(0.5))
}
