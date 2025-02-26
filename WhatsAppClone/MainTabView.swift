//
//  MainTabView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-27.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            Tab("Updates", systemImage: TabItem.updates.icon){
                UpdatesScreenTabItem()
                    .toolbarBackground(.visible, for: .tabBar)
                
            }
            
            Tab("Calls", systemImage: TabItem.calls.icon){
                CallScreenTabItem()
                    .toolbarBackground(.visible, for: .tabBar)
            }
            
            
            Tab("Communities", systemImage: TabItem.communities.icon){
                CommunityScreenTabItem()                    .toolbarBackground(.visible, for: .tabBar)
            }
            
            
            Tab("Chats", systemImage: TabItem.chats.icon){
                ChatScreenTabItem()                    .toolbarBackground(.visible, for: .tabBar)
            }
            
            
            Tab("Settings", systemImage: TabItem.settings.icon){
                SettingScreenTabItem()                    .toolbarBackground(.visible, for: .tabBar)
            }
            
        }
        
        
    }
    
}



extension MainTabView {
   
    private enum TabItem: String{
        case updates, calls, communities, chats, settings
        
        fileprivate var title: String {
            return rawValue.capitalized
        }
       
        fileprivate var icon: String {
            switch self {
            case .updates:
                "circle.dashed.inset.filled"
            case .calls:
                "phone"
            case .communities:
                "person.3"
            case .chats:
                "message"
            case .settings:
                "gear"
            }
            
        }
        
    }
    
    
    
}

#Preview {
    MainTabView()
}
