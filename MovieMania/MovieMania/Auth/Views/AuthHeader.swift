//
//  AuthHeader.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-13.
//

import SwiftUI

struct AuthHeader: View {
    var body: some View {
            Text("Movie Mania")
                .font(.custom("Gagalin-Regular", size: 48))
                .bold()
                .foregroundStyle(.mmOrange)
    }

}

#Preview {
    AuthHeader()
}
