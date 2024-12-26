//
//  ContentView.swift
//  ApexPredator
//
//  Created by Sushant Dhakal on 2024-12-16.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let predators = Predators()
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PredatorType.all
    
    var filteredList:[ApexPredator]{
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
     
    var body: some View {
        
        NavigationStack{
            List(filteredList) { predator in
                NavigationLink{
                    PredatorsDetail(predatorDetails: predator, 
                                    position: .camera(MapCamera(centerCoordinate:predator.location, distance:3000)))

                }label: {
                    HStack{
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color:.white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal,10)
                                .padding(.vertical,5)
                                .background(predator.type.backgroundcolorType)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        withAnimation{alphabetical.toggle()
                            
                        }
                    }label:{
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Picker("Filter", selection: $currentSelection){
                            ForEach(PredatorType.allCases){type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                            
                            
                        }
                    }label:{
                        Image(systemName: "slider.horizontal.3")
                        
                    }
                }
                    
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
