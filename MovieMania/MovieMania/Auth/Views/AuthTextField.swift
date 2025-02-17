//
//  AuthTextField.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-13.
//

import SwiftUI

struct AuthTextField: View {
    
    @Binding var text: String
    var textFieldType: InputType

    var body: some View {
        HStack {
            Image(systemName: textFieldType.imageSystemName)
                .frame(width: 30)

            switch textFieldType {
            case .password:
                SecureField(textFieldType.placeholderType, text: $text)
            default:
                TextField(textFieldType.placeholderType, text: $text)
                    .keyboardType(textFieldType.keyboardType)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
        .font(.headline)
        .foregroundStyle(.white.opacity(0.6))
        .padding()
        .background(Color.gray.opacity(0.18))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 30)
    }
}

extension AuthTextField {
    enum InputType {
        case email, password, customInput(_ placeholder: String, _ imageName: String)

        var placeholderType: String {
            switch self {
            case .email: return "Email"
            case .password: return "Password"
            case .customInput(let placeholder, _): return placeholder
            }
        }

        var imageSystemName: String {
            switch self {
            case .email: return "envelope"
            case .password: return "lock"
            case .customInput(_, let imageName): return imageName
            }
        }

        var keyboardType: UIKeyboardType {
            switch self {
            case .email: return .emailAddress
            default: return .default
            }
        }
    }
}

#Preview {
    NavigationStack{
        AuthTextField(text: .constant(""), textFieldType: .email)
    }.preferredColorScheme(.dark)
}
