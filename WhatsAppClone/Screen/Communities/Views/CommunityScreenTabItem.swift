//
//  CommunityTabItemView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-27.
//

import SwiftUI

struct CommunityScreenTabItem: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment:.leading , spacing: 10){
                    Image(.communities)

                        
                        Text("Stay connected with the community")
                            .font(.title2)
                            
                        Text("Communities brings members together in topic-based group.Any community you added to will appear here")
                            .foregroundStyle(.gray)
                        
                        Button("See example communities >"){
                            
                        }.frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom,10)
                    
                        newCommunityButton()
                        
                    }.padding()
                    
                
               
            }
            .navigationTitle("Communities")
        }
    }
    
    private func newCommunityButton() -> some View{
        Button{
            
        }label: {
            Label("New Community", systemImage: "plus")
                .bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 10))
            
        }.padding(.horizontal,10)
    }
}

#Preview {
    CommunityScreenTabItem()
}
