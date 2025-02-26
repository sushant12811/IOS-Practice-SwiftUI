//
//  MovieDetails.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-11.
//

import SwiftUI

struct MovieDetails: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var movieDetails: Movie.MovieData
    
    @State private  var isFavIconTapped = false
    @State private  var isWatchedTapped = false
    @State private  var isWhishedTapped = false
    
    @StateObject private var favViewModel = DatabaseManagerViewModel()
    @StateObject private var wishedViewModel = DatabaseManagerViewModel()
    @StateObject private var watchedViewModel = DatabaseManagerViewModel()
    @StateObject private var fetchService = FetchService()
    
    
    var body: some View {
        
        ScrollView{
            VStack{
                ImageCardView()
                releaseRatingSection()
                VStack(alignment:.leading, spacing: 10){
                    Text("\(movieDetails.genreNames.joined(separator: " | "))")
                        .foregroundStyle(.gray)
                    
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(movieDetails.overview)
                        .padding(.bottom,10)
                    
                    Text("Cast")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                }.padding(10)
                
                ScrollView( .horizontal, showsIndicators: false){
                    LazyHStack{
                        ForEach(fetchService.movieCast, id: \.id){ cast in
                            CastCardView(movieCasts: cast)
                            
                        }
                    }
                }
                
               
                videoTrailer()
                
            }
            
            
            
            
        }.scrollIndicators(.hidden)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
            .navigationBarBackButtonHidden()
            .toolbar{
                topTrailingButtonForWish()
                topLeadingBackButton()
            }
            .onAppear {
                favViewModel.fetchFromfsfb(collectionName: CollectionNames.favourite.dataName)
                wishedViewModel.fetchFromfsfb(collectionName: CollectionNames.wishedList.dataName)
                watchedViewModel.fetchFromfsfb(collectionName: CollectionNames.watched.dataName)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isFavIconTapped = favViewModel.viewManagerModel.contains { $0.id == movieDetails.id}
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isWhishedTapped = wishedViewModel.viewManagerModel.contains { $0.id == movieDetails.id }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isWatchedTapped = watchedViewModel.viewManagerModel.contains { $0.id == movieDetails.id }
                }
                
                Task{
                    await fetchService.fetchedMovieDetailsTopic(of: movieDetails.id, for: "credits")
                    await fetchService.fetchedMovieDetailsTopic(of: movieDetails.id, for: "videos")
                    
                }
            }
    }
    
    @ToolbarContentBuilder
    private func topTrailingButtonForWish()-> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            wishListButton()
                .shadow(color:.black.opacity(0.8), radius: 5)
        }
        
    }
    
    @ToolbarContentBuilder
    private func topLeadingBackButton()-> some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            Button{
                dismiss()
            }label:{
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Home")
                }
                .foregroundColor(.white)
                .shadow(color:.black.opacity(0.8), radius: 5)
                
            }
        }
        
    }
    
    
    
    //MARK: Poster
    //ImageCard-Poster
    private func ImageCardView()-> some View{
        
        ZStack(alignment: .bottomLeading){
            AsyncImage(url: movieDetails.posterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .foregroundStyle(.white.opacity(0.7))
                        .frame(width: 350, height: 600)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
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
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                case .failure:
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                @unknown default:
                    EmptyView()
                }
            }
            
            HStack{
                Text(movieDetails.title)
                    .font(.largeTitle)
                    .shadow(color: Color.gray.opacity(0.6), radius: 5)
                    .bold()
                    .padding()
                
                
                Spacer()
                
                watchedButton()
                
                Spacer()
                
                favouriteButton()
            }
        }
    }
    
    //MARK: WishList
    private func wishListButton()-> some View {
        IconButtonView(systemName:"bookmark.fill", isTapped: isWhishedTapped, color: .yellow, action: {
            isWhishedTapped.toggle()
            if isWhishedTapped{
                wishedViewModel.addTofbfs(movieDetails, collectionName: CollectionNames.wishedList.dataName)
            }else{
                wishedViewModel.deleteFromfbfs(id: String( movieDetails.id), collectionName: CollectionNames.wishedList.dataName)
            }
        })
    }
    
    //MARK: Already Watched
    private func watchedButton()-> some View {
        IconButtonView(systemName: "checkmark.square.fill", isTapped: isWatchedTapped, color: .green, action: {
            isWatchedTapped.toggle()
            if isWatchedTapped{
                watchedViewModel.addTofbfs(movieDetails, collectionName: CollectionNames.watched.dataName)
            }else{
                watchedViewModel.deleteFromfbfs(id: String( movieDetails.id), collectionName: CollectionNames.watched.dataName)
            }
            
        })
    }
    
    //MARK: Favourites
    private func favouriteButton() -> some View {
        IconButtonView(systemName: "heart.fill", isTapped: isFavIconTapped, color: .red, action: {
            isFavIconTapped.toggle()
            if isFavIconTapped{
                favViewModel.addTofbfs(movieDetails, collectionName: CollectionNames.favourite.dataName)
            }else{
                favViewModel.deleteFromfbfs(id: String( movieDetails.id), collectionName: CollectionNames.favourite.dataName)
            }
        })
    }
    
    //MARK: Relsease Rating Section
    private func releaseRatingSection()-> some View{
        HStack{
            Label("\(movieDetails.releaseDate)", systemImage: "calendar")
            Spacer()
            
            verticalLine()
            Spacer()
            
            Label("\(movieDetails.originalLanguage)", systemImage: "globe")
            Spacer()
            verticalLine()
            
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

//Icon Button
struct IconButtonView: View {
    let systemName: String
    let isTapped: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action:action){
            Image(systemName: systemName)
                .font(.title)
                .foregroundStyle(isTapped ? color : .white)
                .shadow(color: color.opacity(0.5), radius: 5)
                .animation(.easeInOut(duration: 0.5), value: isTapped)
                .padding(.trailing, 10)
            
        }
    }
}

//MARK: Video Trailer
extension MovieDetails {
    func videoTrailer() -> some View {
        VStack(alignment: .leading) {
            Text("Video")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(fetchService.video, id: \.id) { video in
                if video.name == "Official Trailer" {
                    if let url = video.videoURL {
                        Link(destination: url) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Watch Trailer")
                                    .fontWeight(.semibold)
                            }
                            .foregroundStyle(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        }
                    } else {
                        Text("No video available")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    NavigationStack{
        MovieDetails(movieDetails: Movie.MovieData(id: 1, title: "Sonic 3", overview:" When Dr. Indiana Jones – the tweed-suited professor who just happens to be a celebrated archaeologist – is hired by the government to locate the legendary Ark of the Covenant, he finds himself up against the entire Nazi regime.", posterPath:"https://image.tmdb.org/t/p/w500/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg", popularity: 2.0, originalLanguage: "en", releaseDate: "2025-02-10", voteAverage: 1.2, voteCount: 123, genreIds: [53, 28]))
    }
    
    
}
