//
//  AuthHeader.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-02-02.
//

import SwiftUI

struct AuthHeader: View {
    var body: some View {
        HStack{
            Image(.whatsapp)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            Text("WhatsApp")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
               
        }
    }
}

#Preview {
    ZStack{
        Color(Color.teal)
        AuthHeader()
    }
}
