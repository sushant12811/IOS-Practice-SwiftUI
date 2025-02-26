//
//  CastCardView.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-25.
//

import SwiftUI

struct CastCardView: View {
    
    var movieCasts: Cast.CastData
    
    var body: some View {
        VStack {
            AsyncImage(url: movieCasts.profileImage) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: 140, height: 140)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 140, height: 140)
                        .overlay{
                            Circle().stroke(.white, lineWidth: 1)
                        }
                        

                case .failure(_):
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .foregroundColor(.gray.opacity(0.5))
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(spacing: 4) {
                Text(movieCasts.name)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text(movieCasts.character)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .frame(width: 145, height: 180)
        .padding()
    }
}

#Preview {
    CastCardView(movieCasts: .init(id: 1, name: "Sushant", character: "Steve", profilePath: "https://image.tmdb.org/t/p/w500/26X02HYpYte0NIm5ocOPzssPG6n.jpg"))
}
