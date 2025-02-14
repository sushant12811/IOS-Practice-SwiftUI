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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    if !searchText.isEmpty {
                        searchMovie()
                    } else {
                        MovieCategoryView(title: "Popular Movies", movies: fetchService.popularMovies)
                        MovieCategoryView(title: "Top Rated Movies", movies: fetchService.topRatedMovies)
                        MovieCategoryView(title: "Upcoming Movies", movies: fetchService.upcomingMovies)
                    }
                }
                
            }.navigationTitle("Movies")

            .searchable(text: $searchText)
            .animation(.default, value: searchText)
            .onChange(of: searchText) { _,_ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Task {
                        await fetchService.searchMovies(query: searchText)
                    }
                }
            }
            .task {
                await fetchService.fetchMovies(category: "popular")
                await fetchService.fetchMovies(category: "top_rated")
                await fetchService.fetchMovies(category: "upcoming")
            }
        }
        .preferredColorScheme(.dark)
    }
    
    //MARK: Search Functionality
    func searchMovie() -> some View {
        VStack(alignment: .leading) {
            Text("Search Results (\(fetchService.searchResults.count))")
                .font(.headline)
                .bold()
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
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
    }
}


//MARK: Movie Category View
struct MovieCategoryView: View {
    @StateObject private var fetchService = FetchService()

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
                    ForEach(movies) { movie in
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


#Preview {
    NavigationStack{
        HomeView()
    }
    
}


