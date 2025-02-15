//
//  LoginScreen.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-13.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var authScreenModel = AuthScreenModel()
    
    var body: some View {
        VStack{
            Spacer()
            AuthHeader()
                .padding(.bottom,50)
            VStack(alignment:.leading){
                Text("LogIn")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading,30)
                
                AuthTextField(text: $authScreenModel.email, textFieldTYpe: .email)
                
                AuthTextField(text: $authScreenModel.password, textFieldTYpe: .password)
            }
            
            forgotButton()
            
            authButton(buttonTitle: "LogIn", onTap: {
                
            }).disabled(authScreenModel.disabledLogInButton)
            
            Spacer()
        }.preferredColorScheme(.dark)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        
    }
    
    
    //MARK: Forgot Button
    private func forgotButton() -> some View {
        HStack{
            Spacer()
            Button{
                
            }label:{
                Text("Forgot Password ?")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .padding(.trailing,30)
                    .padding(.vertical, 10)
                
            }
        }
    }
}

#Preview {
    LoginScreen()
}
