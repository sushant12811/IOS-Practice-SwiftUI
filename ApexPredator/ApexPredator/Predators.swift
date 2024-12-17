//
//  Predators.swift
//  ApexPredator
//
//  Created by Sushant Dhakal on 2024-12-16.
//

import Foundation

class Predators {
    
    var apexPredator: [ApexPredator] = []
    
    init(){
        decodeApexPredator()
    }
    
    
    func decodeApexPredator () {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredator = try decoder.decode([ApexPredator].self, from: data)
            }catch{
                print("Error while decoding: \(error)")
            }
        }
    }
}
