//
//  AuthButton.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-02-03.
//

import SwiftUI

struct AuthButton: View {
    
    @Environment(\.isEnabled) var isEnabled

    var buttonTitle: String
    let onTap:() -> Void
    
    private  var backgroundColor:Color{
        return isEnabled ?  .white : .white.opacity(0.3)
    }
    
    private  var forgroundColor:Color{
        return isEnabled ?  .green : .white 
    }
    
    var body: some View {
        Button{
            //
        }label:{
            HStack{
                
                Text(buttonTitle)
                Image(systemName: "arrow.right")
                
            }
            
            
        }
        .font(.headline)
        .fontWeight(.semibold)
        .foregroundStyle(forgroundColor)
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: Color.green.opacity(0.2), radius: 10)
        .padding(.horizontal,32)
    }
    
    
//    enum AuthButtonType {
//        case logIn, signUp
//        
//        var authButtonTitle: String {
//            switch self {
//            case .logIn:
//                "Log in Now"
//            case .signUp:
//                "Create an Account"
//            }
//        }
//        
//       
//    }
}

#Preview {
    ZStack{
        Color.teal
        
        AuthButton(buttonTitle: "LogIn"){
            //
        }
    }
}
