//
//  Quotes.swift
//  BBApI
//
//  Created by Sushant Dhakal on 2025-02-06.
//
import Foundation

struct Quote: Codable, Identifiable {
    var id: UUID {
        return UUID()
    }
    let quote: String
    let author: String
  
}


