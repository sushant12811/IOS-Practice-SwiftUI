//
//  MovieCardView.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-10.
//

import SwiftUI

import SwiftUI

struct MovieCardView: View {
    let movies: Movie.MovieData

    var body: some View {
        ZStack {
            VStack {
                    AsyncImage(url: movies.posterURL) { image in
                        image
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .clear, location: 0.5),
                                        .init(color: .black, location: 1)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                    } placeholder: {
                        ProgressView()
                    }

                    Text(movies.title)
                        .font(.headline)
                        .foregroundColor(.white)
                
            }
            .frame(width: 180, height: 280)
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
}

#Preview {
//    MovieCardView(movies: .init(id: 1, title: "Sonic 3", overview:" When Dr. Indiana Jones – the tweed-suited professor who just happens to be a celebrated archaeologist – is hired by the government to locate the legendary Ark of the Covenant, he finds himself up against the entire Nazi regime.", posterPath:"https://image.tmdb.org/t/p/w500/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg", popularity: 2.0, originalLanguage: "en", releaseDate: "123456", voterAverage: 12.3, voteCount: 123))
}
