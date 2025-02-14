//
//  SeeMoreMovieList.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-12.
//

import SwiftUI

struct SeeMoreMovieList: View {
    let category: String
    @StateObject private var fetchService = FetchService()
    @State private var currentPage = 1
    @State private var searchText = ""
    
    let column = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                if !searchText.isEmpty {
                    Text("Search result(\(fetchService.searchResults.count))")
                    LazyVGrid(columns: column, spacing: 10) {
                        
                        ForEach(fetchService.searchResults) { movie in
                            NavigationLink {
                                MovieDetails(movieDetails: movie)
                            } label: {
                                MovieCardView(movies: movie)
                            }
                        }
                    }
                    
                }else{
                    LazyVGrid(columns: column, spacing: 10) {
                        ForEach(getMoviesForCategory()) { movie in
                            NavigationLink{
                                MovieDetails(movieDetails: movie)
                            }label:{
                                MovieCardView(movies: movie)
                                    .onAppear {
                                        if movie.id == getMoviesForCategory().last?.id {
                                            loadMoreData()
                                        }
                                    }
                            }
                            
                        }
                    }
                }
                
            }
            
            .searchable(text: $searchText)
            .animation(.default, value: searchText)
            .onChange(of: searchText, { _, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    Task{
                        await fetchService.searchMovies(query: searchText)
                    }
                }
            })
            .navigationTitle(category.capitalized(with: .none).replacingOccurrences(of: "_", with: " "))
            
            
            .task {
                await fetchService.fetchMovies(category: category, page: currentPage)
            }
        }.preferredColorScheme(.dark)
        
        
    }
    
    private func getMoviesForCategory() -> [Movie.MovieData] {
        switch category {
        case "popular":
            return fetchService.popularMovies
        case "top_rated":
            return fetchService.topRatedMovies
        case "upcoming":
            return fetchService.upcomingMovies
        default:
            return []
        }
    }
    
    private func loadMoreData() {
        currentPage += 1
        Task {
            await fetchService.fetchMovies(category: category, page: currentPage)
        }
    }
    
}

#Preview {
    NavigationStack{
        SeeMoreMovieList(category: "popular")
    }
}


