//
//  Movie.swift
//  MyFavouriteMovies
//
//  Created by Sushant Dhakal on 2025-01-09.
//

import Foundation
import SwiftUI

class Movie:ObservableObject {
    
    var movieData : [MovieData] = []
    
   
    init() {
        decodedMovieData()
    }
    
    //decoded function
    func decodedMovieData (){
        let apiKey = "c3957c0341f6ceb7b221d37abf80c151"
        if let url = Bundle.main.url(forResource: "movies", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                movieData = try decoder.decode([MovieData].self, from: data)
               
                
                
            }catch{
                print("Error: while decoding\(error)")
            }
        }
    }
    
    //Search movie title
    func searchText(for searchTitle: String ) -> [MovieData]{
        if searchTitle.isEmpty {
            return movieData
        }else{
            return movieData.filter{movie in
                movie.title.localizedCaseInsensitiveContains(searchTitle)
            }
        }
        
    }

//    func sortBy(by alphabetical:Bool){
//        movieData.sort { movieData1, movieData2 in
//            if alphabetical{
//                movieData1.title < movieData2.title
//            }else {
//                movieData1.id < movieData2.id
//            }
//        }
//        
//        
//    }
   
   
}
