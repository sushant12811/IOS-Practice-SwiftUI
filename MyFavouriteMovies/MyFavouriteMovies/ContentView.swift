//
//  ContentView.swift
//  MyFavouriteMovies
//
//  Created by Sushant Dhakal on 2025-01-09.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    let movieList = Movie()
    @StateObject var favViewModel = FavouriteViewModel()

    
    @State var searchBar = ""
    @State var alphabetical = false
    
    
    var filteredTitle: [MovieData]{
//        movieList.sortBy(by: alphabetical)
        return movieList.searchText(for: searchBar)
    }
    
    
    var body: some View {
        
        TabView {
            NavigationStack{
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 170), spacing:8)], spacing: 15) {
                            ForEach(filteredTitle) { movie in
                                NavigationLink{
                                    MovieDetails(movieDetails: movie)
                                    
                                }label:{
                                    MovieCard(movie: movie)
                                }
                            }
                        }

                }.navigationTitle("Favourite Movies")
                   .searchable(text: $searchBar)
                   .autocorrectionDisabled()
                    .animation(.default, value: searchBar)
                
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            Text("Favourites")
            FavouriteView()

                .tabItem {
                Label("Favourite", systemImage: "heart")
                }

        }
        .environmentObject(favViewModel)
        .preferredColorScheme(.dark)


      
        
    }
    
}


#Preview {
    ContentView()
}
