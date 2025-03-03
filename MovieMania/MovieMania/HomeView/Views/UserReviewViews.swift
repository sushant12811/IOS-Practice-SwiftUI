//
//  UserReviewViews.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-26.
//

import SwiftUI

struct UserReviewViews: View {
    
    @StateObject private var fetchService = FetchService()
    @Environment(\.dismiss) private var dismiss
    @State private var expandedReviewIds: Set<String> = []
    let movies: Movie.MovieData
    
    var body: some View {
        
        HStack {
            Text("Reviews")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Spacer()
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.gray.opacity(0.5))
                .padding()
                .onTapGesture {
                    dismiss()
                }
        }
        
        ScrollView {
            VStack {
                if fetchService.reviews.isEmpty {
                    Text("No reviews")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                } else {
                    ForEach(fetchService.reviews, id: \.id) { review in
                        VStack(alignment: .leading, spacing: 4) {
                            
                            HStack {
                                urlImage(url: review.authorDetails.avatarImage, width: 40, height: 40, systemImage: "person.fill", shape: RoundedRectangle(cornerRadius: 100))
                                Text(review.author)
                                    .font(.headline)
                                Spacer()
                                
                                HStack(spacing: 2) {
                                    Text(review.authorDetails.rating?.converString() ?? "0")
                                        .font(.caption)
                                    Image(systemName: "star.fill")
                                        .font(.caption)
                                }
                                .padding(5)
                                .background(.mmOrange.opacity(0.8))
                                .clipShape(Capsule())
                            }
                            
                            ZStack(alignment: .bottomTrailing) {
                                VStack(alignment:.leading , spacing: 2) {
                                    formattedText(review.content)
                                        .font(.subheadline)
                                        .lineLimit(expandedReviewIds.contains(review.id)  ? nil : 5)
                                    
                                    if isTextTruncated(review.content) {
                                        readMoreLessButton(id: review.id)
                                    }
                                }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                    .padding(.horizontal, 20)
            }
            .onAppear {
                Task {
                    await fetchService.fetchedMovieDetailsTopic(of: movies.id, for: "reviews")
                }
            }
            .preferredColorScheme(.dark)
        }
        
    //REadMoreLess function
        private func readMoreLessButton(id: String) -> some View {
            Button {
                withAnimation {
                    if expandedReviewIds.contains(id) {
                        expandedReviewIds.remove(id)
                    } else {
                        expandedReviewIds.insert(id)
                    }
                }
            } label: {
                Spacer()
                Text(expandedReviewIds.contains(id) ? "<< Read less" : "Read More >>")
                    .font(.subheadline)
                    .foregroundStyle(.blue)
            }
        }
    }

//Format the text to normal or in http
    private func formattedText(_ text: String) -> some View {
        let words = text.split(separator: " ")
        var finalText: Text = Text("")
        
        for word in words {
            let wordString = String(word)
            if let url = URL(string: wordString), url.scheme == "http" || url.scheme == "https" {
                let linkText = Text(wordString)
                    .foregroundColor(.blue)
                    .underline()
                finalText = finalText + linkText + Text(" ")
            } else {
                finalText = finalText + Text(wordString + " ")
            }
        }
        
        return finalText
    }
    
    // function to check if text is truncated
    private func isTextTruncated(_ text: String) -> Bool {
        let font = UIFont.systemFont(ofSize: 16)
        let lineHeight = font.lineHeight
        let maxHeight = lineHeight * 5
        
        let textWidth = UIScreen.main.bounds.width - 40
        let textHeight = calculateTextHeight(text: text, width: textWidth, font: font)
        
        return textHeight > maxHeight
    }
    
    //  function to calculate text height
    private func calculateTextHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }
    
    
    #Preview {
        UserReviewViews(movies: Movie.mockData)
    }
