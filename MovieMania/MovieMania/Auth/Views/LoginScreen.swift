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
                        .foregroundStyle(.white.opacity(0.9))
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading,30)
                    
                    AuthTextField(text: $authScreenModel.email, textFieldType: .email)
                    
                    AuthTextField(text: $authScreenModel.password, textFieldType: .password)
                }
                
                forgotButton()
                
                AuthButton(buttonTitle: "LogIn") {
                    Task{
                        await authScreenModel.handleLogin()
                    }
                }
                .disabled(authScreenModel.disabledLogInButton)
                
                Spacer()
                
                dntHaveAcc()
            }
            .onTapGesture {
                authScreenModel.hideKeyboard()
            }
            .preferredColorScheme(.dark)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .fullScreenCover(isPresented: $authScreenModel.isLoading) {
                HomeView()
            }
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
    
    //MARK: Don't have an account Text Button
    private func dntHaveAcc()-> some View{
        NavigationLink{
            SignUpScreen(authScreenModel: authScreenModel)
        }label:{
            HStack{
                Image(systemName: "bubbles.and.sparkles.fill")
                (
                    Text("Don't have an account ? ")
                    +
                    Text("Create One")
                        .fontWeight(.bold)
                )
                Image(systemName: "bubbles.and.sparkles.fill")

            }
        }.foregroundStyle(.white.opacity(0.9))
    }
}

#Preview {
    LoginScreen()
}
