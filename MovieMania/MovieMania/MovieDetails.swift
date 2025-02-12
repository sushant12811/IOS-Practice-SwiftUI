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
                releaseRatingSection()
                
                VStack(alignment:.leading, spacing: 10){
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.semibold)
                
                    Text(movieDetails.overview)
                        .padding(.bottom,10)
                }.padding(10)
                    

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
            Text(movieDetails.title)
                .font(.largeTitle)
                .bold()
                .padding()
            
            
            
        }
        
    }
    
    private func releaseRatingSection()-> some View{
        HStack{
            Label("\(movieDetails.releaseDate)", systemImage: "calendar")
            Spacer()
            Label("\(movieDetails.originalLanguage)", systemImage: "globe")
            Spacer()
            HStack{
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("\(movieDetails.voteAverage.converString())")
            }
        }.foregroundStyle(.gray)
        .padding()
        .background(.gray.opacity(0.1))
    }
    }
    




#Preview {
    NavigationStack{
        MovieDetails(movieDetails: .init(id: 1, title: "Sonic 3", overview:" When Dr. Indiana Jones – the tweed-suited professor who just happens to be a celebrated archaeologist – is hired by the government to locate the legendary Ark of the Covenant, he finds himself up against the entire Nazi regime.", posterPath:"https://image.tmdb.org/t/p/w500/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg", popularity: 2.0, originalLanguage: "en", releaseDate: "2025-02-10", voteAverage: 1.2, voteCount: 123))
    }
    
    
}
