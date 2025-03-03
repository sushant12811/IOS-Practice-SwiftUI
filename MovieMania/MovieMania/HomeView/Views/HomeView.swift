//
//  ContentView.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-10.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var fetchService = FetchService()
    
    @State private var searchText = ""
    @StateObject private var authScreenModel = AuthScreenModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    if !searchText.isEmpty {
                        SearchFunction(searchText: $searchText)
                        
                    } else {
                        MovieCategoryView(title: "Popular Movies", movies: fetchService.popularMovies)
                        MovieCategoryView(title: "Top Rated Movies", movies: fetchService.topRatedMovies)
                        MovieCategoryView(title: "Upcoming Movies", movies: fetchService.upcomingMovies)
                    }
                }.searchable(text: $searchText)

            }
            .animation(.smooth, value: searchText)
            .scrollIndicators(.hidden)
            .navigationTitle("Movies")
            .onAppear{
                Task {
                    if fetchService.popularMovies.isEmpty {
                        await fetchService.fetchMovies(category: "popular")
                    }
                    if fetchService.topRatedMovies.isEmpty {
                        await fetchService.fetchMovies(category: "top_rated")
                    }
                    if fetchService.upcomingMovies.isEmpty {
                        await fetchService.fetchMovies(category: "upcoming")
                    }
                }
            }
            
        }
        
    }
}

//MARK: Movie Category View
extension HomeView{
    struct MovieCategoryView: View {
        let title: String
        var movies: [Movie.MovieData]
    
        var body: some View {
            VStack(alignment: .leading) {
                HStack{
                    Text(title)
                        .font(.title3)
                        .bold()
                        .padding(.leading)
                    
                    NavigationLink {
                        SeeMoreMovieList(category: categoryKey(from: title))
                    }label: {
                        HStack {
                            Spacer()
                            Text("See more >>")
                                .padding(.trailing,12)
                        }
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(movies, id: \.id) { movie in
                            NavigationLink{
                                MovieDetails(movieDetails: movie)
                            }label: {
                                MovieCardView(movies: movie)
                                
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        
        func categoryKey(from title: String) -> String {
            switch title {
            case "Popular Movies":
                return "popular"
            case "Top Rated Movies":
                return "top_rated"
            case "Upcoming Movies":
                return "upcoming"
            default: return "popular"
            }
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
    
}


