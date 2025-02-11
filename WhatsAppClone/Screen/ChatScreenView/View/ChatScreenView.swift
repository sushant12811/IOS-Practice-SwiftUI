//
//  ChatScreenView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-28.
//

import SwiftUI

struct ChatScreenView: View {
    var body: some View {
        MessageView()
        .toolbarVisibility(.hidden, for: .tabBar)
        .toolbar{
            leadingTab()
            trailingTab()
        }.safeAreaInset(edge: .bottom) {
            TabTextInputView()
        }
    }
    
    @ToolbarContentBuilder
    private func leadingTab() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack{
                Circle()
                    .frame(width: 40)
                Text("Sabu Mali")
                    .font(.callout)
                    .bold()
                
            
            }.padding(.bottom, 3)
            .padding(.horizontal, 5)}
        
    }
    
    @ToolbarContentBuilder
    private func trailingTab() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button{
                
            }label: {
                Image(systemName: "video")
            }
            
            Button{
                
            }label: {
                Image(systemName: "phone")
            }
        }
    }
}

#Preview {
    NavigationStack{
        ChatScreenView()
    }
}
