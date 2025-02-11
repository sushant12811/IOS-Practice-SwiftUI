//
//  ImageItem.swift
//  MyFavouriteMovies
//
//  Created by Sushant Dhakal on 2025-02-07.
//

import SwiftUI

struct MovieCard: View {
    let movie: MovieData
    var body: some View {
        ZStack{
            VStack{
                AsyncImage(url: movie.imageUrl){ image in
                    image.resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay{
                            LinearGradient(stops:
                                            [Gradient.Stop(color: .clear, location:0.5),
                                             Gradient.Stop(color: .black, location: 1)],
                                            startPoint: .top, endPoint: .bottom)
                        }
                    
                } placeholder: {
                    ProgressView()
                }
                
                
                VStack(alignment: .center){
                    
                    Text (movie.title)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(String(format: "%.1f", movie.criticsRating))")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal,7)
                            .padding(.vertical , 3)
                            .background(movie.getBackgroundColor(for: movie.criticsRating))
                            .clipShape(.capsule)
                    }
                }
            }
            .padding()
            .frame(width: 180, height: 250)
            .background(.white.opacity(0.1))
            .clipShape(.rect(cornerRadius:7))
            .foregroundStyle(.white)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    MovieCard(movie: .init(movieID: 1, title: "The MatrixSushant dhakl", studio: "", genres: [], directors: [], writers: [], actors: [], year: 1234, length: 12, shortDescription: "", mpaRating: "", criticsRating: 12, imageUrl:URL(string: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRXYv9ia2yMhzZEBW4-vkFQkNQY6provFWUNtTrYBnJXDNbqN8mSU2n3FYN7fCiWYzmthBMLg"  )!))
}
