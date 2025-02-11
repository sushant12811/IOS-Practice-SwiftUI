//
//  MessageItem.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-29.
//

import Foundation
import SwiftUI

struct MessageItem: Identifiable {
    let id = UUID()
    let text: String
    let messageType : MessageType
    let direction: MessageDirection
    
    static let sentPlaceholder = MessageItem(text: "Hello Sabu? How you are doing?", messageType: .text, direction: .sent)
    static let recievedPlaceholder = MessageItem(text: "Hello Sushant? How you are doing?", messageType: .video, direction: .recieved)
    
    static let stubMessages: [MessageItem] =
    [
    .init(text: "hello?", messageType: .text, direction: .sent),
    .init(text: "photo please", messageType: .photo, direction: .recieved),
    .init(text: "here is the video", messageType: .video, direction: .sent),
    .init(text: "here is the video", messageType: .audio, direction: .sent)

    ]
    
    var alignment: Alignment{
        return direction == .recieved ? .leading : .trailing
    }
    
    var horizontalAlignment: HorizontalAlignment {
        return direction == .recieved ? .leading : .trailing
        
    }

    
    var backgroundBubble: Color{
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
}

enum MessageType{
    case text, photo, video, audio
}

enum MessageDirection {
    case sent, recieved

    }


