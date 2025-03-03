//
//  WatchCardViews.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-26.
//

import SwiftUI

struct ServiceProviderCardViews: View {
    
    
    var services : Services
    
    var body: some View {
        VStack{
            
            AsyncImage(url: services.logoImage){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: 50, height: 50, alignment: .leading)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .leading)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(color: .white.opacity(0.4), radius: 3)
                    
                case .failure:
                    Image(systemName: "Film")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .leading)
                        .clipShape(.rect(cornerRadius: 10))
                        .foregroundStyle(.gray)
                    
                    
                @unknown default:
                    EmptyView()
                }
                
                
                
                
            }
            
            Text("\(services.providerName)")
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }.preferredColorScheme(.dark)
    }
}


#Preview {
    ServiceProviderCardViews(services: Services(providerId: 1, logoPath: "https://image.tmdb.org/t/p/w200/9ghgSC0MA082EL6HLCW3GalykFD.jpg", providerName: "Apple", displayPriority: 6))
}
