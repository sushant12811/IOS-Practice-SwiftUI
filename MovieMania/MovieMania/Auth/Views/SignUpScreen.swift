//
//  SignUpScreen.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-15.
//

import SwiftUI

struct SignUpScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authScreenModel : AuthScreenModel
    let usernameTextFieldType = AuthTextField.InputType.customInput("Username", "person.crop.circle")
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                
                AuthHeader()
                
                AuthTextField(text: $authScreenModel.email, textFieldType: .email)
                
                AuthTextField(text: $authScreenModel.username, textFieldType: usernameTextFieldType)
                
                AuthTextField(text: $authScreenModel.password, textFieldType: .password)
                
                AuthButton(buttonTitle: "SignUp") {
                    print("tapped")
                    Task{
                        await authScreenModel.handleSignup()
                    }
                }
                .disabled(authScreenModel.disabledSignUpButton)
                
                Spacer()
                
                alHaveAcc()
            }
        }
            .onTapGesture {
                authScreenModel.hideKeyboard()
            }
            .background(linearGradient())
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $authScreenModel.isLoading, destination: {
                HomeView()
            })
            .ignoresSafeArea()
    }
    
    //Linear Gradient:- For background
    private func linearGradient() -> some View{
        LinearGradient(colors: [Color.mmOrange.opacity(0.45), Color.black, Color.gray.opacity(0.35)], startPoint: .top, endPoint: .bottom)
    }
    
    //MARK: Already have an account Text
    private func alHaveAcc()-> some View{
        Button{
            dismiss()
        }label:{
            HStack{
                Image(systemName: "bubbles.and.sparkles.fill")
                (
                    Text("Already have an account ? ")
                    +
                    Text("LogIn")
                        .fontWeight(.bold)
                )
                Image(systemName: "bubbles.and.sparkles.fill")
            }
        }.foregroundStyle(.white.opacity(0.9))
            .padding(.bottom,30)
    }
}

#Preview {
    ZStack{
        SignUpScreen(authScreenModel: AuthScreenModel())
    }.preferredColorScheme(.dark)
}
