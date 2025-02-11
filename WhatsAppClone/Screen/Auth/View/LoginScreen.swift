//
//  LoginScreen.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-02-02.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var authScreenModel = AuthScreenModel()
    
    var body: some View {
        VStack{
            Spacer()
            AuthHeader()
            AuthTextField(text: $authScreenModel.email, formType: .email)
            AuthTextField(text: $authScreenModel.password, formType: .password)
            
            forgotTextButton()
            
            AuthButton(buttonTitle: "LogIn")
            {
            }.disabled(authScreenModel.disabledLoginButton)
            
            
            Spacer()
            
            dontAccountBtn()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.teal)
    }
    
    
    private func forgotTextButton()-> some View{
        Button{
            
        }label:{
            HStack{
                Spacer()
                
                Text("Forgot Password ?")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .padding(.trailing, 32)
                    .padding(.vertical)
            }
        }
    }
    
    private func dontAccountBtn() -> some View {
        NavigationLink{
            SignUpScreen(authScreenModel: authScreenModel)
        }label: {
            
            HStack {
                Image(systemName: "sparkles")
                
                (
                    Text("Don't have an account ? ")
                    +
                    Text("Create one")
                        .fontWeight(.semibold)
                )
                
                Image(systemName: "sparkles")
                
            }.padding(.vertical,30)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    LoginScreen()
    
}
