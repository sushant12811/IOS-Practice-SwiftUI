//
//  AuthDisplayModel.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-15.
//

import Foundation
import FirebaseAuth
import SwiftUI


@MainActor
final class AuthScreenModel: ObservableObject{
    @Published var isLoading:Bool = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var erroState: (showError: Bool, errorMessage: String) = ( false, "Sorry")

    
    //MARK: Computed Properties
    var disabledLogInButton:Bool{
        return email.isEmpty || password.isEmpty
    }
    
    var disabledSignUpButton:Bool{
        return email.isEmpty || username.isEmpty || password.isEmpty
    }
    
    
    //MARK: Handle SignUp
    func handleSignup() async {
        do {
            try await AuthManagerService.shared.signUp(for: username, with: email, and: password)
            isLoading = true
        }catch{
            erroState.errorMessage = "Failed to signup\(error.localizedDescription)"
            erroState.showError = true
            isLoading = false
            print("Signup Error: \(error)")
        }
        
    }
    
  
    
    
    //MARK: Handle SignIn
    func handleLogin() async {
        do{
            try await AuthManagerService.shared.signIn(with: email, and: password)
        }catch{
            erroState.errorMessage = "Failed to logged in \(error.localizedDescription)"
            erroState.showError = true
            isLoading = false
            print("Login Error: \(error)")
        }
    }
    
    //MARK: Handle SignOut
    func handleLogout() async {
        do {
            try await AuthManagerService.shared.logOut()
            isLoading = false
        } catch {
            erroState.errorMessage = "Failed to log out: \(error.localizedDescription)"
            erroState.showError = true
            isLoading = false
            print("LogOut Error: \(error)")
            
        }
    }
    
  
}






