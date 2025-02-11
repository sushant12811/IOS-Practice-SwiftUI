//
//  SignUpScreen.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-02-03.
//

import SwiftUI

struct SignUpScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject  var authScreenModel: AuthScreenModel
    
    var body: some View {
        VStack{
            Spacer()
            AuthHeader()
            AuthTextField(text: $authScreenModel.email, formType: .email)
            
            let usernameText = AuthTextField.InputType.customInput("Username", "at")
            
            AuthTextField(text: $authScreenModel.username, formType: usernameText)
           
            AuthTextField(text: $authScreenModel.password, formType: .password)
            
            AuthButton(buttonTitle: "Create an account"){
                Task{
                    await authScreenModel.handleSignup()
                }
                
            }.disabled(authScreenModel.disabledSignUpButton)

            Spacer()
            
            alreadyAcnt()
                
            
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(linearGraident())
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
        
    }
    
    private func linearGraident() -> some View {
        LinearGradient(colors:[.green,.green.opacity(0.8), .teal], startPoint: .top, endPoint: .bottom)
    }
    
    private func alreadyAcnt()-> some View {
        Button{
            dismiss()
        }label: {
            HStack {
                Image(systemName: "sparkles")
                
                (
                    Text("Already have an account ? ")
                    +
                    Text("Login")
                        .fontWeight(.semibold)
                )
                
                Image(systemName: "sparkles")
                
            }.padding(.vertical,30)
                .foregroundStyle(.white)
        }
    
    }
}

#Preview {
    SignUpScreen(authScreenModel: AuthScreenModel())
}
