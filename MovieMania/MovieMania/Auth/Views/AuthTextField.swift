//
//  AuthTextField.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-13.
//

import SwiftUI

struct AuthTextField: View {
    
    @Binding var text: String
    
    var textFieldTYpe: InputType
    
    var body: some View{
        
        HStack{
            Image(systemName: textFieldTYpe.ImageSystemName)
            
            switch textFieldTYpe {
        //email has already UIKeyBoad type
                
            case .password:
                SecureField(textFieldTYpe.PlaceHolderType, text: $text)
            
            default:
                //this default case could be use fo custom input as well
                TextField(textFieldTYpe.PlaceHolderType, text: $text)
            }
            
            
        }.font(.headline)
        .foregroundStyle(.gray)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.18))
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal,30)
        
        
    }
    
}

extension AuthTextField{
    enum InputType{
        case email, password, customInput( _ placeholder: String, _ imageName: String)
        
        var PlaceHolderType: String{
            switch self {
            case .email:
                    "Email"
            case .password:
                "Password"
            case .customInput( let placeholder, _):
                placeholder
            }
        }
        
        var ImageSystemName: String{
            switch self {
            case .email:
                "envelope"
            case .password:
                "lock"
            case .customInput( _, let imageName):
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
        AuthTextField(text: .constant(""), textFieldTYpe: .email)
    }.preferredColorScheme(.dark)
}
