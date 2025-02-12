//
//  FavouriteView.swift
//  MyFavouriteMovies
//
//  Created by Sushant Dhakal on 2025-02-10.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var favViewModel: FavouriteViewModel

        var body: some View {
            NavigationStack {
                List {
                    ForEach(favViewModel.favourites) { movie in
                        NavigationLink(destination: MovieDetails(movieDetails: movie)) {
                            HStack {
                                AsyncImage(url: movie.imageUrl) { image in
                                    image.resizable().scaledToFit().frame(width: 50, height: 75)
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack(alignment: .leading) {
                                    Text(movie.title).font(.headline)
                                    Text(movie.studio).font(.subheadline).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            favViewModel.removeFromFavorites(favViewModel.favourites[index])
                        }
                    }
                }
                .navigationTitle("Favourites")
            }
        }
    }

#Preview {
    FavouriteView()
        .environmentObject(FavouriteViewModel())
}
