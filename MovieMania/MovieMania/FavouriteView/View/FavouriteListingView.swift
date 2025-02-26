//
//  FavouriteListing.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-19.
//

import SwiftUI

struct FavouriteListingView: View {
    @StateObject private var favMovies = DatabaseManagerViewModel()
    @StateObject private var fetchService = FetchService()

    let column = [GridItem(), GridItem()]
    var body: some View {
        NavigationStack{
            ScrollView{
                if !favMovies.viewManagerModel.isEmpty{
                    LazyVGrid(columns: column){
                        ForEach(favMovies.viewManagerModel){ movie in
                            NavigationLink{
                                MovieDetails(movieDetails: movie)
                                
                            }label:{
                                MovieCardView(movies: movie)
                            }
                        }
                    }
                }else{
                    Text("No Favourites Movies")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .padding()
                }
            }.toolbar{
                DeleteAll(collection: .favourite) 

                }
            
            
            .onAppear{
                Task{
                    favMovies.fetchFromfsfb(collectionName: CollectionNames.favourite.dataName)
                }
            }.navigationTitle("Favourites")
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    FavouriteListingView()
}
