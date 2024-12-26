//
//  PredatarMapView.swift
//  ApexPredator
//
//  Created by Sushant Dhakal on 2024-12-25.
//

import SwiftUI
import MapKit

struct PredatarMapView: View {
    
    @State var position: MapCameraPosition
    @State var mapStyle = false
    let predators = Predators()
    
    var body: some View {
        Map(position: $position){
            ForEach(predators.apexPredator){predatorLocation in
                Annotation(predatorLocation.name, coordinate: predatorLocation.location){
                    
                    Image(predatorLocation.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 125)
                        .scaleEffect(x: -1)
                        .shadow(color:. white, radius: 4)
                    
                }
                
                
            }
            
        }.mapStyle( mapStyle ?.imagery(elevation: .realistic) : .standard)
            .overlay(alignment: .bottomTrailing){
                Button(){
                    mapStyle.toggle()
                }label:{
                    Image(systemName: mapStyle ? "globe.americas.fill" : "globe.americas")
                }   .font(.largeTitle)
                    .padding(.trailing, 5)
            }
        
        
    }
}

#Preview {
    PredatarMapView(position: .camera(MapCamera(centerCoordinate: Predators().apexPredator[2].location, distance: 1000, pitch: 80)))
}
