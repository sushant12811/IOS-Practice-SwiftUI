//
//  BubbleTailView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-29.
//

import SwiftUI

struct BubbleTailView: View {
    
    var direction: MessageDirection
    
    var backGroundColor: Color {
        return direction == .sent ? .bubbleGreen : .whatsAppWhite
    }
    
    var body: some View {
        Image(direction == .sent ? .outgoingTail : .incomingTail)
            .renderingMode(.template)
            .resizable()
            .offset(x: direction == .sent ? 3 : -3, y: 5)
            .frame(width: 15, height: 10)
            .foregroundStyle(backGroundColor)
        
    }
}

#Preview {
    BubbleTailView(direction: .sent)

}
