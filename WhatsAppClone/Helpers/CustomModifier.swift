//
//  CustomHelpers.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-29.
//

import SwiftUI

private struct BubbleViewModifier: ViewModifier {
  
    var direction: MessageDirection
    
    func body(content: Content) -> some View {
        content.overlay(alignment: direction == .sent ? .bottomTrailing : .bottomLeading) {
            BubbleTailView(direction: direction)
        }
    }
    
}

extension View {
    func applyTail(_ direction : MessageDirection) -> some View {
        self.modifier(BubbleViewModifier(direction: direction))
    }
    
    
}
