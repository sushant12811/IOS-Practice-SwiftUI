//
//  WelcomeView.swift
//  WeatherClone
//
//  Created by Sushant Dhakal on 2025-02-10.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack(alignment:.center, spacing: 20){
            Text("Welcome to Weather App")
                .font(.title)
                .bold()
                .padding()
            Text("Please share your location to get weather information")
                .font(.headline)
            
            LocationButton(.shareCurrentLocation){
                locationManager.requestLocation()
                
            }
            
             .symbolVariant(.fill)
             .clipShape(.rect(cornerRadius: 25))
             
            
        }
        .foregroundStyle(.white)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.navyBlue)

    }
}

#Preview {
    WelcomeView()
}
