//
//  TabTextInputView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-28.
//

import SwiftUI

struct TabTextInputView: View {
    
    @State private var textInput = ""
    
    var body: some View {
        HStack(alignment:.bottom, spacing: 10){
            
            //Upload Image
            imageUpload()
            
            //audio recoding
            tabButtons("mic.fill")
            
            //Typing text area
            textInputArea()
            
            //Send Content
            tabButtons("arrow.up")
   
                
        }.padding()
         .padding(.vertical,2)
         .background(.whatsAppWhite)
    }
    
    
    private func imageUpload()->some View{
        Image(systemName:"photo.on.rectangle")
            .font(.title3)
    }
    
    private func tabButtons(_ image: String) -> some View {
        Image(systemName: image)
            .padding(5)
            .background(.blue)
            .foregroundStyle(.white)
            .bold()
            .clipShape(.circle)
    }
    
    
    private func textInputArea()-> some View{
        TextField("", text: $textInput, axis: .vertical)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 20).fill(.thinMaterial))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
    }
}

#Preview {
    TabTextInputView()
}
