//
//  AuthServiceProvider.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-16.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState {
    case Pending, loggedIn, Signout
}

protocol AuthServiceProvider {
    static var shared:AuthServiceProvider {get}
    var authState: CurrentValueSubject<AuthState, Never> {get}
    func signUp(for username: String, with email: String, and password: String) async throws
    func signIn(with email: String, and password: String) async throws
    func autoSignIn() async
    func logOut() async throws
}


//MARK: AuthManagerService
final class AuthManagerService : AuthServiceProvider {
    private init(){
        
    }
    
    static let shared: AuthServiceProvider = AuthManagerService()
    
    var authState = CurrentValueSubject<AuthState, Never>(.Pending)
    
    
    //SignUp
    func signUp(for username: String, with email: String, and password: String) async throws {
        do{
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            let newUser = UserDetails(uid: uid, username: username, email: email, password: password)
            
            try await saveUserInfotoDB(user: newUser)
        }catch{
            print ("Error in signingUp: \(error.localizedDescription)")
        }
        
    }
    
    //SignIn
    func signIn(with email: String, and password: String) async throws {
        do{
            try await Auth.auth().signIn(withEmail: email, password: password)
            authState.send(.loggedIn)
        }catch{
            print ("Error in signingUp: \(error.localizedDescription)")
            
        }
    }
    
    //AutoSignIn
    func autoSignIn() async {
        
    }
    
    
    //SignOut
    func logOut() async {
        do {
            try Auth.auth().signOut()
            authState.send(.Signout)
        } catch let error as NSError {
            print("❌ Sign-out failed: \(error.localizedDescription)")
        }
    }
}


//MARK: Saved User Data to DB
extension AuthManagerService{
    private func saveUserInfotoDB(user:UserDetails) async throws {
        let userInfo = ["uid": user.uid, "username": user.username, "email": user.email]
        try await Database.database().reference().child("users").child(user.uid).setValue(userInfo)
    }
}

struct UserDetails: Identifiable, Hashable, Decodable{
    let uid: String
    let username: String
    let email: String
    let password: String
    var profileImageUrl: String? = nil
    
    var id: String{
        return uid
    }
    
}
