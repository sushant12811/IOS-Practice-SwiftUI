//
//  SettingItemView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-28.
//

import SwiftUI

struct SettingItemView: View {
    
    let item: SettingsItem
    
    var body: some View {
        HStack(spacing: 10){
            
            imageAssetsView()
                .frame(width:30, height: 30)
                .foregroundStyle(.white)
                .background(item.backgroundColor)
                .clipShape(.rect(cornerRadius: 5))
            
            Text(item.title)
                .font(.title3)
            
        }
        
        
    }
    
    @ViewBuilder
    private func imageAssetsView() -> some View {
        
        switch item.imageType {
            
        case .systemImage:
            Image(systemName: item.imageName)
                .bold()
                .font(.callout)
            
        case .assetImage:
            Image(item.imageName)
                .renderingMode(.template)
                .padding(3)

        }
    }
}

#Preview {
    SettingItemView(item: .avatar)
    SettingItemView(item: .chats)

}
