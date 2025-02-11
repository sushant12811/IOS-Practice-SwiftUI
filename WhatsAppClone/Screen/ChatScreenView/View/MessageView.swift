//
//  MessageView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-29.
//

import SwiftUI

struct MessageView: UIViewControllerRepresentable{
    typealias UIViewControllerType = MessageViewController
    
    func makeUIViewController(context: Context) -> MessageViewController {
        let messageListViewController = MessageViewController()
        return messageListViewController
    }
    
    func updateUIViewController(_ uiViewController: MessageViewController, context: Context) {
    }
    
    
    
    
    
    
}

#Preview {
   
        MessageView()
    
}
