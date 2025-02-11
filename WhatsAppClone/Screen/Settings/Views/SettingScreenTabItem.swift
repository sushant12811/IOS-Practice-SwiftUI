//
//  SettingScreenTabItem.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-28.
//

import SwiftUI

struct SettingScreenTabItem: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            List{
                
                Section{
                    AccountInfo()
                }
                
                Section{
                    SettingItemView(item: .broadCastLists)
                    SettingItemView(item: .starredMessages)
                    SettingItemView(item: .linkedDevices)
                }
                
                Section{
                    SettingItemView(item: .account)
                    SettingItemView(item: .privacy)
                    SettingItemView(item: .chats)
                    SettingItemView(item: .notifications)
                    SettingItemView(item: .storage)

                }
                
                Section{
                    SettingItemView(item: .help)
                    SettingItemView(item: .tellFriend)

                }

                
            }.navigationTitle("Settings")
                .searchable(text: $searchText)
        }
        
    }
    
}

private struct AccountInfo: View {
    var body: some View {
        HStack(alignment: .top){
            Circle()
                .frame(width: 55)
            
            userInfo()
            
            Spacer()
            Image(.qrcode)
                .renderingMode(.template)
                .foregroundStyle(.blue)
                .padding(5)
                .background(Color(.systemGray5))
                .clipShape(.circle)
            
        }
        
        SettingItemView(item: .avatar)
    }
    
    private func userInfo() -> some View {
        VStack(alignment:.leading){
            Text("Sushant Dhakal")
                .font(.title2)
            Text("Hey there! I am using WhatsApp.")
                .font(.callout)
                .foregroundStyle(.gray)

        }.lineLimit(1)
        
    }


    
}
    
#Preview {
    SettingScreenTabItem()
}
