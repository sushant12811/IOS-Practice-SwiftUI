//
//  AuthScreenModel.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-02-03.
//

import Foundation

final class AuthScreenModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var erroState: (showError: Bool, errorMessage: String) = ( false, "Sorry")
    
   //Computed Properties
  
    var disabledLoginButton: Bool{
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disabledSignUpButton: Bool{
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }
    
    func handleSignup() async {
        isLoading = true
        do {
            try await AuthManager.shared.signUp(for: username, with: email, and: password)
        }catch{
            erroState.errorMessage = "Failed to signup\(error.localizedDescription)"
            erroState.showError = true
            isLoading = false
        }
        
    }
}
