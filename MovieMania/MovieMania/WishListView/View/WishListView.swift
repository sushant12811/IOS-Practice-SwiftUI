//
//  WishListView.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-20.
//

import SwiftUI

struct WishListView: View {
    @StateObject private var wishMovies = DatabaseManagerViewModel()
    @StateObject private var fetchService = FetchService()

    let column = [GridItem(), GridItem()]
    var body: some View {
        NavigationStack{
            ScrollView{
                if !wishMovies.viewManagerModel.isEmpty{
                    LazyVGrid(columns: column){
                        ForEach(wishMovies.viewManagerModel){ movie in
                            NavigationLink{
                                MovieDetails(movieDetails: movie)
                                
                            }label:{
                                MovieCardView(movies: movie)
                            }
                        }
                    }
                }else{
                    Text("No WishList Added")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .padding()
                }
            }.toolbar{
                DeleteAll(collection: .wishedList) 
            }
            
            .onAppear{
                Task{
                    wishMovies.fetchFromfsfb(collectionName: CollectionNames.wishedList.dataName)
                }
            }.navigationTitle("WishList")
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    WishListView()
}
