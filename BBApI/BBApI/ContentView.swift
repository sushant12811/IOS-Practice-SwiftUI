//
//  ContentView.swift
//  BBApI
//
//  Created by Sushant Dhakal on 2025-02-06.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var post = FetchService()
    private var isLoading = false
    
    var body: some View {
        NavigationStack{
            VStack {
                List(post.quotes)
                { item in
                    VStack(alignment: .leading){
                        

                        Text("\" \(item.quote)\"")
                            .font(.headline)
                            .fontWeight(.light)
                            .padding(.vertical,5)
                            .foregroundStyle(.yellow)
                        Text(item.author)
                            .fontWeight(.semibold)
                            .font(.title3)
                            .foregroundStyle(.green.opacity(0.8))
                        
                        
                        
                    }.padding(.horizontal,5)
                    
                    
                }
                .listStyle(.grouped)
                .navigationTitle("Breaking Bad Quotes")
                
                
                randomQuotes()
                    
                   
            }
            
            
            
        }
       
        .preferredColorScheme(.dark)
    }
    
    
    
    private func randomQuotes()-> some View {
        Button("Random Quotes") {
            Task{
                await post.fetchData()
                
                 }
            }   .padding()
                .frame(maxWidth: .infinity)
                .background(.green.opacity(0.8))
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
                .clipShape(.rect(cornerRadius: 15, style: .continuous))
                .padding()
                .padding(.horizontal,20)
        
            
    }
    
}



#Preview {
    ContentView()
}
