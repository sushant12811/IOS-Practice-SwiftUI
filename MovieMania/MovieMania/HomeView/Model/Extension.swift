//
//  Extension.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-11.
//

import Foundation
import SwiftUI


extension Double {
    func converString() -> String{
        return String(format:"%.1f", self)
    }
    
    
}

extension String{
    func baseURL()-> String {
        return "https://image.tmdb.org/t/p/w500"
    }
}

extension View {
    func urlImage(url: URL?, width: CGFloat, height: CGFloat, systemImage: String, shape: RoundedRectangle) -> some View {

    VStack {
             if let url = url {
                 AsyncImage(url: url) { phase in
                     switch phase {
                     case .empty:
                         ProgressView()
                     case .success(let image):
                         image
                             .resizable()
                             .frame(width: width, height: height)
                             .clipShape(shape)
                     case .failure:
                         Image(systemName: systemImage)
                             .resizable()
                             .frame(width: width, height: height)
                     @unknown default:
                         EmptyView()
                     }
                 }
             } else {
                 Image(systemName: systemImage)
                     .resizable()
                     .frame(width: width, height: height)
             }
         }
     }
 }
 
extension View {
    @ViewBuilder
    func textModifier(text: String) -> some View{
        Text(text)
            .font(.headline)
            .foregroundStyle(.gray)
        
    }
    
    @ViewBuilder
    func trunctedText(of text: String, is expanded : Bool)-> some View{
        Text(text)
            .lineLimit(expanded ? nil : 4)
            .truncationMode(.tail)
        
    }
    
    @ToolbarContentBuilder
    func trailingBarItem(systemName: String, action:@escaping () -> Void)-> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                action()
            }label:{
                Image(systemName: systemName)
            }
            
    
            
        }
    }
    
    
}



