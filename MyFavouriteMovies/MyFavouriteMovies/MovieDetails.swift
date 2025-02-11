//
//  MovieDetails.swift
//  MyFavouriteMovies
//
//  Created by Sushant Dhakal on 2025-01-10.
//

import SwiftUI

struct MovieDetails: View {
    
    let movieDetails: MovieData
    @EnvironmentObject var favManager: FavouriteViewModel
    
    @State var isFavIconTapped = false
    @State private var isZoomed = false
    
    var releaseYear: String {
        return String("\(movieDetails.year)")
    }
    
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading){
                ZStack(alignment: .bottomLeading){
                    AsyncImage(url: movieDetails.imageUrl){ image in
                        image.resizable()
                            .aspectRatio(contentMode: isZoomed ? .fill : .fit)
                            .onTapGesture {
                                isZoomed.toggle()
                            }
                            .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 10, topTrailing: 10)))
                            .overlay{
                                LinearGradient(stops: [
                                    Gradient.Stop(color: .clear, location: 0.5),
                                    Gradient.Stop(color: .black, location: 1)],
                                               startPoint: .top, endPoint: .bottom)
                            }
                    } placeholder: {
                        ProgressView()
                    }
                    HStack {
                        Text(movieDetails.title)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .shadow(color: .gray, radius: 5)
                        
                        Spacer()
                        Button {
                            if isFavIconTapped {
                                favManager.removeFromFavorites(movieDetails)
                            } else {
                                favManager.addToFavorites(movieDetails)
                            }
                            isFavIconTapped.toggle()
                        } label: {
                            Image(systemName: "heart.fill" )
                                .imageScale(.large)
                                .foregroundColor(isFavIconTapped ? .red : .white)
                                .animation(.easeInOut, value: isFavIconTapped)
                        }
                    }.padding(.horizontal, 15)
                    
                }
                HStack{
                    Label("\(movieDetails.length) min", systemImage: "clock")
                    Spacer()
                    Text("MPA- \(movieDetails.mpaRating)")
                    Spacer()
                    Label("\(releaseYear)", systemImage: "calendar")
                    
                }
                .foregroundStyle(.gray)
                .padding()
                
                MovieDetailsSubView(movieDetailsSV: movieDetails)
            }
            
            
            
            
        }.ignoresSafeArea()
            .preferredColorScheme(.dark)
            .toolbarBackground(.automatic)
            .onAppear {
                        isFavIconTapped = favManager.favourites.contains(where: { $0.movieID == movieDetails.movieID })
                    }
        
    }
    
    
}

#Preview {
    NavigationStack{
        MovieDetails(movieDetails: Movie().movieData[1])
        
    }
}



//Extracted Subview for details of moviedetails
struct MovieDetailsSubView: View {
    
    let movieDetailsSV : MovieData
    
    var body: some View {
        
        
        VStack (alignment:.leading){
            Text("Stars")
                .font(.title)
                .fontWeight(.medium)
            
            ForEach(movieDetailsSV.actors, id: \.self){movie in
                Text(" ► \(movie)")
            }
            Text("Description")
                .font(.title)
                .fontWeight(.medium)
                .padding(.top, 10)
            Text(movieDetailsSV.shortDescription)
            
            Text("Directors")
                .font(.title)
                .fontWeight(.medium)
                .padding(.top, 10)
            ForEach(movieDetailsSV.directors, id: \.self){movie in
                Text("► \(movie)")
            }
            Text("Writers")
                .font(.title)
                .fontWeight(.medium)
                .padding(.top, 10)
            
            ForEach(movieDetailsSV.writers, id: \.self){movie in
                Text("►  \(movie)")
                
            }
        }.padding(.horizontal,15)
        
    }
}
