//
//  FavouriteListing.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-19.
//

import SwiftUI

struct WatchedListView: View {
    
    @StateObject private var watchedMovies = DatabaseManagerViewModel()
    @State private var showDeleteAlert = false
    @StateObject private var fetchService = FetchService()
    
    let column = [GridItem(), GridItem()]
    var body: some View {
        NavigationStack{
            ScrollView{
                if !watchedMovies.viewManagerModel.isEmpty{
                    LazyVGrid(columns: column){
                        ForEach(watchedMovies.viewManagerModel){ movie in
                            NavigationLink{
                                MovieDetails(movieDetails: movie)
                                
                            }label:{
                                MovieCardView(movies: movie)
                            }
                        }
                    }
                }else{
                    Text("No Watched Movies Added")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .padding()
                }
            }.navigationTitle("Watched List")
                .toolbar {
                    DeleteAll(collection: .watched)
                }
                .onAppear{
                    Task{
                        watchedMovies.fetchFromfsfb(collectionName: CollectionNames.watched.dataName)
                    }
                }
        }.preferredColorScheme(.dark)
    }
}


#Preview {
    WatchedListView()
}
