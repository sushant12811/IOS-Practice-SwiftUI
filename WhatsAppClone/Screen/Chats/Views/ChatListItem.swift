//
//  ChatItemView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-28.
//

import SwiftUI

struct ChatListItem: View {
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .foregroundStyle(.white)
                .imageScale(.large)
                .font(.largeTitle)
                .padding()
                .background(Color(.gray).opacity(0.8))
                .clipShape(.circle)
            
            chatItemDetails()
             
        }
    }
    
    
    private func chatItemDetails() -> some View{
        HStack {
            VStack(alignment: .leading){
                Text("Sabu Mali")
                    .font(.title3)
                    .bold()
                HStack{
                    Image(systemName: "mic.fill")
                    Text("Voice Message")
                }.foregroundStyle(.gray)
                    .font(.callout)
            }
            
            Spacer()
            Text("5:41 PM")
                .foregroundStyle(.gray)
                .font(.callout)
        }
        
    }
    }
#Preview {
    ChatListItem()
}
