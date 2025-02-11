//
//  BubbleTextView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-29.
//

import SwiftUI

struct BubbleTextView: View {
    
    let item: MessageItem
    
    var body: some View {
        VStack (alignment: item.horizontalAlignment, spacing: 3){
            Text(item.text)
                .padding(10)
                .background(item.backgroundBubble)
                .clipShape(.rect(cornerRadius: 10))
                .applyTail(item.direction)
            
            timeStamp()

        }.shadow(color: Color(.systemGray3).opacity(0.1), radius: 5 , x: 0, y:20)
            .frame(maxWidth: .infinity, alignment: item.alignment)
            .padding(.leading, item.direction == .recieved ? 5 : 100)
            .padding(.trailing, item.direction == .recieved ? 100 : 5)
        

    }
    private func timeStamp() -> some View {
        HStack {
            Text("2:05 PM")
                .fontWeight(.light)
                .font(.caption)
                .foregroundStyle(.gray)
            
            
            if item.direction == .sent {
                Image(.seen)
                    .renderingMode(.template)
                    .frame(width: 15)
                    .foregroundStyle(.blue)
            }else{
                
            }
        }
    }
}

#Preview {
    BubbleTextView(item:.sentPlaceholder )
    BubbleTextView(item:.recievedPlaceholder )

}
