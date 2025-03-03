//
//  ActorsView.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-28.
//

import SwiftUI

struct ActorsView: View {
    @StateObject private var fetchService = FetchService()
    @Environment(\.dismiss) var dismiss
    @State private var isExpanded = false
    var actorView : Actor
    var body: some View {
        NavigationStack{
            ScrollView{
                //Images and AKA
                HStack(alignment: .top){
                    urlImage(url: actorView.profileImage, width: 160, height: 200, systemImage: "person.fill", shape: RoundedRectangle(cornerRadius: 20))
                        .overlay{
                            RoundedRectangle(cornerRadius: 20).stroke(.mmOrange, lineWidth: 1)
                        }
                    Spacer()
                    VStack(alignment: .leading, spacing: 7){
                        Text("\(actorView.name)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom,10)
                        textModifier(text: "AKA")
                        ForEach(actorView.alsoKnownAs?.prefix(5) ?? [], id: \.self){aka in
                            Text("► \(aka)")
                            
                        }
                        
                        
                    }
                    
                }
                .padding()
                
                //Details Like gender, DOB
                VStack(alignment: .leading, spacing: 10){
                    textModifier(text: "Gender")
                    Text(actorView.genderId)
                    Divider()
                    textModifier(text: "Date of Birth")
                    Text((actorView.birthday ?? "N/A"))
                    Divider()
                    textModifier(text: "Place of Birth")
                    Text(actorView.placeOfBirth ?? "N/A")
                    Divider()
                    deathDayContent()
                    Divider()
                    textModifier(text: "Department")
                    Text(actorView.knownForDepartment)
                    Divider()
                    textModifier(text: "Biography")
                    trunctedText(of: actorView.biography, is: isExpanded)
                    readMoreLessButton()
                    Divider()
                    textModifier(text: "About")
                    homePageButton()
                    
                    
                }
                .padding()
                .clipShape(.rect(cornerRadius: 10))
                
                
                
                
            }.frame(maxWidth: .infinity)
                .toolbar{
                    trailingBarItem(systemName: "xmark"){
                        dismiss()
                    }
                }
                .scrollIndicators(.hidden)
                .navigationTitle("\(actorView.name)")
                .navigationBarTitleDisplayMode(.inline)
                .preferredColorScheme(.dark)
        }
        
    }
    
    
    //ReadMoreLessButton Trigger
    private func readMoreLessButton()-> some View{
        HStack{
            Spacer()
            Button{
                withAnimation {
                    isExpanded.toggle()
                }
            }label: {
                Text(isExpanded ? "<< Read less" : "Read more >>")
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.trailing,10)
            }
        }
    }
    
    //Home Page Button
    @ViewBuilder
    private func homePageButton()-> some View{
        HStack{
            Spacer()
            if let urlString = actorView.homepage, let url = URL(string: urlString) {
                Link("Visit Homepage", destination: url)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.accent)
                    .padding()
                    .background(.mmOrange)
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(color:.gray, radius: 4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12).stroke(.white, lineWidth: 1)
                    }

            }else{
                Text("Not Available")
            }
            Spacer()

        }
    }
    
    //Death Content
    @ViewBuilder
    private func deathDayContent()-> some View {
        if let deathday = actorView.deathday, !deathday.isEmpty {
        
            textModifier(text: "Died")
            Text(deathday)
                .foregroundColor(.red)
        }
    }
    
    
    }
    
    

#Preview {
    NavigationStack{
        ActorsView(actorView: Actor.mockData )
    }
}
