//
//  Predators.swift
//  ApexPredator
//
//  Created by Sushant Dhakal on 2024-12-16.
//

import Foundation

class Predators {
    
    var allApexpredators:[ApexPredator] = []
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
                allApexpredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredator = allApexpredators
            }catch{
                print("Error while decoding: \(error)")
            }
        }
    }
    
    func search(for searchItem: String)-> [ApexPredator] {
        if searchItem.isEmpty {
            return  apexPredator
        }else{
            return apexPredator.filter{predator in
            predator.name.localizedCaseInsensitiveContains(searchItem)
    
            }
        }
    }
    
    func sort(by alphabetical: Bool){
        apexPredator.sort{predator1, predator2 in
            if alphabetical{
                predator1.name < predator2.name
            }else{
                predator1.id < predator2.id
            }
        }
        
    }
    
    func filter(by type: PredatorType){
        if type == .all{
            apexPredator = allApexpredators
            
        }else{
            apexPredator = allApexpredators.filter{ predatorType in
                predatorType.type == type
                
            }
        }
    }
    
}
