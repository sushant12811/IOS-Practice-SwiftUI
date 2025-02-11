//
//  FetchService.swift
//  BBApI
//
//  Created by Sushant Dhakal on 2025-02-06.
//


import Foundation

class FetchService: ObservableObject{
    
    @Published var quotes : [Quote] = []
    
   func fetchData() async {
        guard let url = URL(string: "https://api.breakingbadquotes.xyz/v1/quotes/10") else
        {
            print ("Sorry no fetching")
            return
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data){
                
                await MainActor.run {
                    quotes = decodedResponse
                    print("Data fetched successfully: \(quotes)")
                }
            }
            
        }catch{
            print("Failed to fetch data: \(error.localizedDescription)")
        }
        
    }
    
}


