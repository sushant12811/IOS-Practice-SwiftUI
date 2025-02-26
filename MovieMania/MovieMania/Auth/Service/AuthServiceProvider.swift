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
    case Pending, loggedIn(UserDetails), Signout
}

protocol AuthServiceProvider {
    static var shared:AuthServiceProvider {get}
    var authState: CurrentValueSubject<AuthState, Never> {get}
    func signUp(for username: String, with email: String, and password: String) async throws
    func signIn(with email: String, and password: String) async throws
    func autoSignIn() async
    func logOut() async throws
}



//MARK: AuthError
enum AuthError:Error {
    case failedToCreateAccount(_ description: String)
    case failedTosaveUserInfo(_ description: String)
    case failedToLogin(_ description: String)
    
    
    
}

extension AuthError: LocalizedError {
    var errorDescription: String?{
        switch self {
        case .failedToCreateAccount(let description):
            return description
        case .failedTosaveUserInfo(let description):
            return description
        case .failedToLogin(let description):
            return description
        }
    }
}


//MARK: AuthManagerService
final class AuthManagerService : AuthServiceProvider {
    private init() {
        
        Task{
            await autoSignIn()
        }
        
    }
    
    static let shared: AuthServiceProvider = AuthManagerService()
    
    var authState = CurrentValueSubject<AuthState, Never>(.Pending)
    
    
    //SignUp
    func signUp(for username: String, with email: String, and password: String) async throws {
        do{
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            let newUser = UserDetails(uid: uid, username: username, email: email)
            
            try await saveUserInfotoDB(user: newUser)
            authState.send(.loggedIn(newUser))
            
            
        }catch{
            print ("Error in signingUp: \(error.localizedDescription)")
            throw AuthError.failedToCreateAccount(error.localizedDescription)
        }
        
    }
    
    //SignIn
    func signIn(with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchUserDetails()
            print("Successfullly signedIn by \(authResult.user.email ?? "")")
        }catch{
            print("Failed to login: \(email)")
            throw AuthError.failedToLogin(error.localizedDescription)
            
            
        }
        
    }
    
    //AutoSignIn
    func autoSignIn() async {
        if Auth.auth().currentUser == nil {
            authState.send(.Signout)
        }else {
            fetchUserDetails()
            print("Fetched Current User")
        }
    }
    
    //SignOut
    func logOut() async {
        do {
            try Auth.auth().signOut()
            authState.send(.Signout)
            print("SignedOut Successfully")
        } catch let error as NSError {
            print("❌ Sign-out failed: \(error.localizedDescription)")
        }
    }
}


//MARK: Saved User Data to DB
extension AuthManagerService{
    private func saveUserInfotoDB(user:UserDetails) async throws {
        do{
            let userInfoDict : [String: Any] = [.uid: user.uid, .username: user.username, .email: user.email]
            try await FirebaseConstants.user.child(user.uid).setValue(userInfoDict)
        }catch{
            print("Failed to save userInfo: \(error.localizedDescription)")
            throw AuthError.failedTosaveUserInfo(error.localizedDescription)
        }
    }
    
    private func fetchUserDetails() {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        FirebaseConstants.user.child(currentUid).observe(.value) {[weak self] snapshotData in
            guard let userDict = snapshotData.value as? [String: Any] else {return}
            let loggedInUser = UserDetails(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("\(loggedInUser.username) user logged in")
            
        } withCancel: { error in
            print ("Failed to fetch userInfo")
        }
    }
}


