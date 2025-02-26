//
//  RootScreen.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-18.
//

import SwiftUI

struct RootScreen: View {
    @StateObject private var rootViewModel = RootScreenModel()
    var body: some View {
        NavigationStack{
            switch rootViewModel.authState{
            case .Pending :
                ProgressView()
                    .controlSize(.large)
            case .loggedIn(let loggedInUser):
                MainTabItem(currentUserDetails: loggedInUser)

            case .Signout:
                LoginScreen()
            }
        }.transition(.opacity)
            .preferredColorScheme(.dark)
    }
}

#Preview {
    RootScreen()
}
