//
//  SearchFunction.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-20.
//

import SwiftUI

struct SearchFunction: View {
    @StateObject private var fetchService = FetchService()
    @Binding var searchText: String
    let columns = [GridItem(), GridItem()]

    var body: some View {
        VStack(alignment: .center) {
                if fetchService.searchResults.isEmpty {
                    Text("No result 😕")
                        .foregroundStyle(.gray)
                        .font(.headline)
                }
                ScrollView(showsIndicators: false){
                    LazyVGrid (columns: columns){
                        ForEach(fetchService.searchResults) { movie in
                            NavigationLink{
                                MovieDetails(movieDetails: movie)
                            }label:{
                                MovieCardView(movies: movie)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
                      .onChange(of: searchText) { _,_ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            Task {
                                await fetchService.searchMovies(query: searchText)
                            }
                        
                    }
            }
        
        }
    
    
}

#Preview {
    SearchFunction(searchText: .constant(""))
}
