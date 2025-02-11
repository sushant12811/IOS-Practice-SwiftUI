//
//  MovieDetails.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-11.
//

import SwiftUI

struct MovieDetails: View {

    let movieDetails: Movie.MovieData
    
    var body: some View {
        
        ScrollView{
            VStack{
                ImageCardView()
                Text(movieDetails.overview)
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        .toolbarBackground(.automatic)
        
    }
    
    
    //MARK: Poster
    //ImageCard-Poster
    private func ImageCardView()-> some View{
        ZStack(alignment: .bottomLeading){
            AsyncImage(url: movieDetails.posterURL){ image in
                image.resizable()
                    .scaledToFit()
                    .overlay{
                        LinearGradient(stops: [
                            Gradient.Stop(color: .clear, location: 0.4),
                            Gradient.Stop(color: .black, location: 1)],
                                       startPoint: .top, endPoint: .bottom)
                    }
                
            }placeholder: {
                ProgressView()
            }
            
            HStack{
                Text(movieDetails.title)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Text(movieDetails.releaseDate)
                    .foregroundStyle(.gray)
                
                Text("\(String(format: "%.1f", movieDetails.voteAverage))")
            }
        }

    }
    
}



#Preview {
    NavigationStack{
        MovieDetails(movieDetails: .init(id: 1, title: "Sonic 3", overview:" When Dr. Indiana Jones – the tweed-suited professor who just happens to be a celebrated archaeologist – is hired by the government to locate the legendary Ark of the Covenant, he finds himself up against the entire Nazi regime.", posterPath:"https://image.tmdb.org/t/p/w500/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg", popularity: 2.0, originalLanguage: "en", releaseDate: "2025-02-10", voteAverage: 12.3, voteCount: 123))
    }
    
    
}
