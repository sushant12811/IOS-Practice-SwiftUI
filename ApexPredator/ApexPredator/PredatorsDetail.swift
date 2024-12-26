//
//  PredatorsDetail.swift
//  ApexPredator
//
//  Created by Sushant Dhakal on 2024-12-24.
//

import SwiftUI
import MapKit

struct PredatorsDetail: View {
    
    let predatorDetails: ApexPredator
    @State var position: MapCameraPosition
    
    
    var body: some View {
        GeometryReader {geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    
                    Image(predatorDetails.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1)],
                                           startPoint: .top, endPoint: .bottom)
                        }
                    
                    Image(predatorDetails.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y:20)
                }
                
                VStack(alignment:.leading){
                    Text(predatorDetails.name)
                        .font(.largeTitle)
                    NavigationLink{
                        Image(predatorDetails.image)
                    }label:{
                        Map(position: $position ){
                            Annotation(predatorDetails.name, coordinate: predatorDetails.location){
                                Image(systemName: "mappin.and.ellipse"
                                ).font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                                
                            }
                            .annotationTitles(.hidden)
                        }.frame(height: 125)
                            .overlay(alignment: .trailing){
                                Image(systemName: "chevron.right")
                                    .font(.largeTitle)
                                    .padding(.trailing,10)
                            }.overlay(alignment: .topLeading){
                                Text("Current Location")
                                    .padding(5)
                                    .background(.black .opacity(0.33))
                                    .clipShape(.rect(bottomTrailingRadius: 15))
                                
                            } .clipShape(.rect(cornerRadius: 15))
                        
                        
                    }
                    Text("Appears In:")
                        .font(.title)
                        .padding(.top,10)
                    
                    ForEach(predatorDetails.movies, id: \.self){movie in
                        Text(" • \(movie)")
                    }
                    
                    ForEach(predatorDetails.movieScenes){ scene in
                        Text(scene.movie)
                            .font(.title)
                            .padding(.top, 15)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                        
                        
                    }
                    
                    Text("Read More:")
                        .font(.caption)
                    Link(predatorDetails.link, destination: URL(string: predatorDetails.link)!)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.top,10)
                .frame(width:geo.size.width, alignment: .leading)
                
                
            }
            .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
        .toolbarBackground(.automatic)
    }
}


#Preview {
    NavigationStack{
        PredatorsDetail(predatorDetails: Predators().apexPredator[2], position: .camera(MapCamera(centerCoordinate: Predators().apexPredator[2].location, distance: 30000)))
    }
}
