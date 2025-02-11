//
//  BubbleAudioView.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-31.
//

import SwiftUI

struct BubbleAudioView: View {
    
    let item: MessageItem
    @State private var initialSliderValue:Double = 0
    @State private var sliderRange: ClosedRange<Double> = 0...20
    
    
    var body: some View {
        VStack(alignment:item.horizontalAlignment) {
            HStack{
                
                playButton()
                
                slider()
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .tint(.gray)
                
            }
                .padding(10)
                .background(.gray.opacity(0.4))
                .clipShape(.rect(cornerRadius: 10))
                .padding(5)
                .background(item.direction == .recieved ? .white : .bubbleGreen)
                .clipShape(.rect(cornerRadius: 10))
                .applyTail(item.direction)
            
            timeStamp()

        }.shadow(color: Color(.systemGray3).opacity(0.1), radius: 5 , x: 0, y:20)
            .frame(maxWidth: .infinity, alignment: item.alignment)
            .padding(.leading, item.direction == .recieved ? 5 : 100)
            .padding(.trailing, item.direction == .recieved ? 100 : 5)
        
    }
    
    
    
    private func playButton()-> some View{
        Image(systemName: "play.fill")
            .padding(10)
            .foregroundStyle(item.direction == .recieved ? .white : .black)
            .background(item.direction == .recieved ? .green : .white)
            .clipShape(.circle)
    }
    
    
    private func slider()-> some View{
        Slider(value: $initialSliderValue, in: sliderRange) {
            Text("Slider")
        } minimumValueLabel: {
            Text("")
        } maximumValueLabel: {
            Text("3.00")
        }
    }
    
    
    private func timeStamp()-> some View{
        HStack {
            Text("12:49")
            Image(.seen)
                .renderingMode(.template)
                .foregroundStyle(.blue)
        }
        .font(.system(size: 12))
        .foregroundStyle(.gray)

        
        
    }
}

#Preview {
    ScrollView{
        BubbleAudioView(item: .recievedPlaceholder)
        BubbleAudioView(item: .sentPlaceholder)
    }.frame(maxWidth: .infinity)
        .background(Color(.systemGray5))
    
}
