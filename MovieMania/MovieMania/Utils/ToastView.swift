//
//  ToastView.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-19.
//

import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .padding()
            .background(Color.green.opacity(0.3))
            .foregroundColor(.white)
            .cornerRadius(10)
            .offset(y:230)
            .transition(.opacity)
            .animation(.easeInOut, value: message)
    

    }
}

#Preview {
    ToastView(message: "Logged In")
        .preferredColorScheme(.dark)
}
