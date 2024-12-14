//
//  Currency.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-12-14.
//

import SwiftUI

enum Currency: Double {
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var image : ImageResource {  //computed properties
        switch self {
        case .copperPenny:
                .copperpenny
        case .silverPenny:
                .silverpenny
            
        case .silverPiece:
                .silverpiece
            
        case .goldPenny:
                .goldpenny
            
        case .goldPiece:
                .goldpiece
            
        }
        
    }
        var text : String{ // Computed Properties
            switch self {
            case .copperPenny:
                "Copper Penny"
            case .silverPenny:
                "Silver Penny"
            case .silverPiece:
                "Silver Piece"
            case .goldPenny:
                "Gold Penny"
            case .goldPiece:
                "Gold Piece"
                
            }
            
        }
        
        
    
}