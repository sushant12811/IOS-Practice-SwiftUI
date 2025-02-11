//
//  AuthTextField.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-02-02.
//

import SwiftUI

struct AuthTextField: View {
    
    @Binding  var text: String
    
    var formType: InputType
    
    
    var body: some View {
        HStack{
            
            Image(systemName: formType.ImageSystem)
            
            switch formType {
            case .password:
                SecureField(formType.inputPlaceholder, text: $text)
            default:
                TextField(formType.inputPlaceholder, text: $text)
                    .keyboardType(formType.keyBoardType)

            }
            
        }
        .font(.headline)
        .foregroundStyle(.white)
        .padding()
        .background(.white.opacity(0.4))
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal,32)
    }
}
    
    extension AuthTextField{
        enum InputType {
            case email, password, customInput(_ placeholder: String, _ imageName: String
            )
            
            var inputPlaceholder: String {
                switch self {
                case .email:
                     "Email"
                case .password:
                     "Password"
                case .customInput(let placeholder, _):
                       placeholder
                }
            }
            
            var ImageSystem: String {
                switch self {
                case .email:
                    "envelope"
                case .password:
                    "lock"
                case .customInput(_ , let imageName):
                    imageName
                }
            }
            
            var keyBoardType: UIKeyboardType{
                switch self {
                case .email:
                        .emailAddress
                        
                default:
                        .default
                        
                    
                }
            }
            
        }
        
        
    }
    


#Preview {
    ZStack{
        Color.teal
        AuthTextField(text: .constant(" "), formType: .email )
    }
}
