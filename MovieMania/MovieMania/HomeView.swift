//
//  ContentView.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-10.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var fetchService = FetchService()
    
    @State var searchText = ""
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    MovieSectionView(title: "Popular Movies", movies: fetchService.popularMovies)
                    MovieSectionView(title: "Top Rated Movies", movies: fetchService.topRatedMovies)
                    MovieSectionView(title: "Upcoming Movies", movies: fetchService.upcomingMovies)
                    
                }.searchable(text: $searchText)
                    .navigationTitle("Movies")
                    .task {
                        await fetchService.fetchMovies(category: "popular")
                        await fetchService.fetchMovies(category: "top_rated")
                        await fetchService.fetchMovies(category: "upcoming")
                    }
            }
            .preferredColorScheme(.dark)
        }
    }
        
    }
    
    struct MovieSectionView: View {
        let title: String
        let movies: [Movie.MovieData]
        
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .bold()
                    .padding(.leading)
                
            
                
                    
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
        
    }
        
        
 #Preview {
            NavigationStack{
                HomeView()
            }
            
        }
        
    
