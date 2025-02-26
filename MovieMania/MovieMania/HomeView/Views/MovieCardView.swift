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
                AsyncImage(url: movies.posterURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .foregroundStyle(.white.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .overlay {
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .clear, location: 0.5),
                                        .init(color: .black, location: 1)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )

                                .transition(.opacity)
                            }
                    case .failure:
                        Image(systemName: "film")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white.opacity(0.5))
                            .frame(width: 190, height: 240)
                            .background(Color.gray.opacity(0.3))
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack (spacing:4){
                    Text(movies.title)
                        .font(.headline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .multilineTextAlignment(.center)

                    Text("(\(releaseYear))")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
            }.padding(.bottom, 7)
            .frame(width: 200, height: 340)
            .clipShape(RoundedRectangle(cornerRadius: 10))

          

        }
        
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
    

}

//MARK: Release Year Date Formatting
extension MovieCardView{
    var releaseYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: movies.releaseDate) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        } else {
            return "N/A"
        }
    }}
#Preview {
    MovieCardView(movies: .init(id: 1, title: "Sonic 3", overview:" When Dr. Indiana Jones – the tweed-suited professor who just happens to be a celebrated archaeologist – is hired by the government to locate the legendary Ark of the Covenant, he finds himself up against the entire Nazi regime.", posterPath:"https://image.tmdb.org/t/p/w500/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg", popularity: 2.0, originalLanguage: "en", releaseDate: "123456", voteAverage: 12.3, voteCount: 123, genreIds: [53, 28]))
}
