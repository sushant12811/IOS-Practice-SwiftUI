//
//  BubbleImageView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-30.
//

import SwiftUI

struct BubbleImageView: View {
    
    var item: MessageItem
    
    var body: some View {
        HStack{
                    
            if item.direction == .sent {
                HStack{
                    Spacer()

                    shareButton()
                    
                        ImageContent()
                        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5 , x: 0, y:20)
                        .overlay {
                            playButton()
                                .opacity(item.messageType == .video ? 1 : 0)
                        }
                        
                    
                    
                }
            }else {
                HStack{
                    ImageContent()
                    
                        .overlay{
                            playButton()
                                .opacity(item.messageType == .video ? 1 : 0)

                        }
                    shareButton()
                    Spacer()

                }
            }
        }
        
    }
    
    private func shareButton ()-> some View {
        Image(systemName: "arrowshape.turn.up.right.fill")
            .renderingMode(.template)
            .foregroundStyle(.white)
            .padding(6)
            .background(Color(.systemGray3))
            .clipShape(.circle)
        
    }
    
    private func ImageContent() -> some View {
        ZStack (alignment: .bottomTrailing){
            VStack(alignment: .leading){
                    Image(.stubImage0)
                        .resizable()
                        .scaledToFit()
                        .frame( height: 160)
                        .clipShape(.rect(cornerRadius: 10))
        
                Text(item.text)
                    .padding(.leading, 5)

            }
                .padding(.top, 3)
                .padding(.bottom, 10)
                .padding(.horizontal,3)
                .background(item.backgroundBubble)
                .clipShape(.rect(cornerRadius: 10))
                .applyTail(item.direction)
            

            timeStamptext()
                .padding(.bottom, 42)
                .padding(.horizontal, 12)
            
            
        }
        
    }
    
    private func timeStamptext()-> some View{
        HStack{
            Text("2:05PM")
                .padding(.leading, 7)
            Image(.seen)
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 15)
                .padding(.trailing,5)
        }
        .font(.caption2)
        .foregroundStyle(.white)
         .background(Color(.systemGray3))
         .clipShape(.capsule)
        

    }
    
    private func playButton()->some View {
        Button{
        }label:{
            Image(systemName: "play.circle.fill")
                .foregroundStyle(Color(.systemGray4))
                .font(.largeTitle)
                .imageScale(.large)
                .background(.gray)
                .padding(-4)
                .clipShape(.circle)
        }
    }
}



#Preview {
    ScrollView{
        BubbleImageView(item: .sentPlaceholder)
        BubbleImageView(item: .recievedPlaceholder)
    }.background(.gray)

}
