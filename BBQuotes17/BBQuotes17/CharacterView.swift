//
//  CharacterView.swift
//  BBQuotes17
//
//  Created by Sushant Dhakal on 2025-01-15.
//

import SwiftUI

struct CharacterView: View {
    
    let character: Char
    let show: String
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment:.top){
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                
                ScrollView{
                    AsyncImage(url: character.images[0]){ image in
                        image
                            .resizable()
                            .scaledToFill()
                        
                    }placeholder: {
                        ProgressView()
                    }
                    .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                    .clipShape(.rect(cornerRadius: 50))
                    .padding(.top, 60)
                    
                    VStack(alignment: .leading){
                        Text(character.name)
                            .font(.title)
                        
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        Divider()
                        
                        Text("\(character.name) Character Info")
                            .font(.title2)
                        Text("Born: \(character.birthday)")
                        
                        Divider()
                        Text("Occupation: ")
                        ForEach(character.occupations, id: \.self){occu in
                            Text("•\(occu)")
                                .font(.subheadline)
                        }
                        Divider()
                        Text("Nicknames: ")
                        if character.aliases.count > 0 {
                            ForEach(character.aliases, id: \.self){alias in
                                Text("•\(alias)")
                                    .font(.subheadline)
                            }
                        }else{
                            Text("None")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        DisclosureGroup("Status: Spoiler alert:"){
                            VStack {
                                Text(character.status)
                                    .font(.title)
                                
                                if let death = character.death {
                                    AsyncImage(url: death.image){ image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(.rect(cornerRadius:15))
                                        
                                    }placeholder: {
                                        ProgressView()
                                    }
                                    
                                    Text("How: \(death.details)")
                                    
                                    Divider()
                                    Text("Last words: \"\(death.lastWords)\"")

                                }
                                
                            }.frame(maxWidth: .infinity, alignment:.leading)
                            
                        }.tint(.primary)
                        
                    }.frame(width: geo.size.width/1.25, alignment: .leading)
                    .padding(.bottom, 30)

                    
                    
                } .scrollIndicators(.hidden)           }
        }.ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
}
