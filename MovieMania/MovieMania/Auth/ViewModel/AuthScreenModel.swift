//
//  AuthDisplayModel.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-15.
//

import Foundation

final class AuthScreenModel: ObservableObject{
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var erroState: (showError: Bool, errorMessage: String) = ( false, "Sorry")
    
    //MARK: Computed Properties
    
    var disabledLogInButton:Bool{
        return email.isEmpty || password.isEmpty
    }
}
