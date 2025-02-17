//
//  authButton.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-15.
//

import SwiftUI

struct AuthButton: View {
    
    @Environment(\.isEnabled) var isEnabled
    var buttonTitle: String
    let onTap:() -> Void
    
    var backgroundColor: Color{
        isEnabled ? .white.opacity(0.93) : .mmOrange.opacity(0.2)
    }
    
    var foregroundCOlor: Color {
        isEnabled ? .mmOrange : .white
    }
    
    var body: some View {
        Button{
            onTap()
            
        }label: {
            HStack{
                Text(buttonTitle)
                Image(systemName: "arrow.right")
                
            }.font(.headline).fontWeight(.semibold)
                .foregroundStyle(foregroundCOlor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(color:.mmOrange.opacity(0.5), radius: 5)
                .padding(.horizontal,30)
        }
    }
}

#Preview {
    ZStack{
        AuthButton(buttonTitle: "LogIn", onTap:{
            
        })
    }.preferredColorScheme(.dark)
}
