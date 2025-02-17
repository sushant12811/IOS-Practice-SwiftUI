//
//  AuthProvider.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-02-04.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase


enum AuthState {
    case pending, loggedIn, loggedOut
}

protocol AuthProvider {
    
    static var shared: AuthProvider {get}
    var authState: CurrentValueSubject<AuthState, Never>{get}
    func signUp(for username: String, with email: String, and password: String) async throws
    func logIn(with email: String, and password: String) async throws
    func autoLogin() async
    func logOut() async throws
}

final class AuthManager: AuthProvider {
    
    private init(){
        
    }
    
    static let shared: AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)

    
    func signUp(for username: String, with email: String, and password: String) async throws {
        
        do{
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            let newUser = UserDetails(uid: uid, username: username, email: email, password: password)
            
            try await saveUseInfotoDB(user: newUser)
        }catch{
            print("Failed to create an account: \(error.localizedDescription)")
        }
        
        
    }
    
    func logIn(with email: String, and password: String) async throws {
        
    }
    
    func autoLogin() async {
        
    }
    
    func logOut() async throws {
        
    }
    
    
}

extension AuthManager{
    private func saveUseInfotoDB(user: UserDetails) async throws{
        let userInfo = ["uid": user.uid, "username": user.username, "email": user.email]
        try await Database.database().reference().child("users").child(user.id).setValue(userInfo)
    }
}

struct UserDetails: Identifiable, Hashable, Decodable {
    let uid: String
    let username: String
    let email: String
    let password: String
    var bio: String? = nil
    var profilImageUrl: String? = nil
    
    var id: String {
        return uid
    }
    
    var bioUnwrapped: String{
        return bio ?? "Hey there! I am using WhatsApp"
    }
    
}
