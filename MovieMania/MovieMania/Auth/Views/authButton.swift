//
//  authButton.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-15.
//

import SwiftUI

struct authButton: View {
    
    @Environment(\.isEnabled) var isEnabled
    var buttonTitle: String
    let onTap:() -> Void

    
    var backgroundColor: Color{
        isEnabled ? .white : .mmOrange.opacity(0.3)
    }
    
    var foregroundCOlor: Color {
        isEnabled ? .mmOrange : .white
    }
    
    var body: some View {
        Button{
            
        }label: {
            Text(buttonTitle)
            Image(systemName: "arrow.right")
                

            
        }   .font(.headline).fontWeight(.semibold)
            .foregroundStyle(foregroundCOlor)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal,30)
    }
}

#Preview {
    ZStack{
        authButton(buttonTitle: "LogIn", onTap:{
            
        })
    }.preferredColorScheme(.dark)
}
