//
//  SeeMoreMovieList.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-12.
//

import SwiftUI
import Foundation

struct SeeMoreMovieList: View {
    let category: String
    @StateObject private var fetchService = FetchService()
    @State private var currentPage = 2
    @State private var searchText = ""
    @State private var isLoading = false
    
    let column = [GridItem(), GridItem()]
    
    private var moviesForCategory: [Movie.MovieData] {
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
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    if !searchText.isEmpty {
                        SearchFunction(searchText: $searchText)
                    }else{
                        LazyVGrid(columns: column, spacing: 10) {
                            ForEach(moviesForCategory, id: \.id) { movie in
                                NavigationLink{
                                    MovieDetails(movieDetails: movie)
                                }label:{
                                    MovieCardView(movies: movie)
                                        .onAppear {
                                            if movie.id == moviesForCategory.last?.id {
                                                loadMoreData()
                                            }
                                        }
                                }
                            }
                        }
                        if isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                } .searchable(text: $searchText)

            }
            .padding()
            .scrollIndicators(.hidden)
            .navigationTitle(category.capitalized(with: .none).replacingOccurrences(of: "_", with: " "))
            
            .task {
                await fetchService.fetchMovies(category: category, page: currentPage)
                
            }
            
        }.preferredColorScheme(.dark)
        
        
    }
    
    
    private func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        currentPage += 1
        Task {
            await fetchService.fetchMovies(category: category, page: currentPage)
            isLoading = false
        }
    }
    
}

#Preview {
    NavigationStack{
        SeeMoreMovieList(category: "popular")
    }
}


