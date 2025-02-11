//
//  ChatScreenTabItem.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-27.
//

import SwiftUI

struct ChatScreenTabItem: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            List{
                ArchivedButtonView()
                
                ForEach(0..<12){_ in
                    NavigationLink{
                        ChatScreenView()
                    } label:{
                        ChatListItem()
                    }
                }
                
              footer()
               
            }.navigationTitle("Chats")
                .searchable(text: $searchText)
                .listStyle(.plain)
                .toolbar{
                    leadToolbarItem()
                    trailToolbarItem()
                }
            
        }
    }
}

extension ChatScreenTabItem{
    
    // leadingToolbarItem
    @ToolbarContentBuilder
    private func leadToolbarItem()-> some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            Menu{
                Button{
                    
                }label:{
                    Label("Select Chats", systemImage: "checkmark.circle")
                }
                
            }label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
    
    
    @ToolbarContentBuilder
    private func trailToolbarItem()-> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            
            //AI Button
            //Camera button
            //Add button
            trailingButtons()

            
        }
    }
    
    private func trailingButtons () -> some View{
        HStack(spacing: 15){
            Button{
                
            }label: {
                Image(.circle)
            }
            
            Button{
                
            }label: {
                Image(systemName: "camera")
            }
            
            Button{
                
            }label: {
                Image(.plus)
            }
        }
       
    }
    
}



private struct ArchivedButtonView: View {
    var body: some View {
        Button{
        }label:{
            Label("Archived", systemImage: "archivebox.fill")
                .bold()
                .foregroundStyle(.gray)
                .padding()
            
        }
        
    }
   
    
}

private func footer()->some View {
    HStack{
        Image(systemName: "lock.fill")
        (
        Text("Your personal messages are ")
        +
        Text("end-to-end encrypted")
            .foregroundStyle(.blue)
        )
    }.foregroundStyle(.gray)
        .font(.caption)
        .padding(.horizontal)
}


#Preview {
    ChatScreenTabItem()
}





