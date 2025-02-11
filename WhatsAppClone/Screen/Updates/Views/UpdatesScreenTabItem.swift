//
//  UpdatesScreenTabItem.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-27.
//

import SwiftUI

struct UpdatesScreenTabItem: View {
    
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack{
            List{
                
                //status
                
                Section{
                    StatusHeader()
                        .listRowBackground(Color.clear)
                        .listSectionSeparator(.hidden)
                    
                }header:{
                    Text("Status")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.black)
                        .textCase(nil)
                }
                
                //Mystatus
                MyStatusSection()
                
                //recently updates
                
                Section{
                    
                    RecentStatusSection()
                    
                }header: {
                    Text("Recently Updates")
                        .bold()
                }
                
                //Channels
                Section{
                    ChannelSection()
                    
                }header:{
                    
                    ChannelSectionHeader()
                }
                
                
            }.navigationTitle("Updates")
                .searchable(text: $searchText)
                .listStyle(.grouped)
            
            
            
            
        }
    }
}


//Status Section
private struct StatusHeader: View {
    var body: some View {
        HStack(alignment: .top){
            Image(systemName: "circle.dashed")
                .foregroundStyle(.tint)
                .imageScale(.large)
            
            VStack(alignment: .leading){
                Text("Use Status to share photos, text and videos that disappear in 24 hours")
                
                Text("Status Privacy")
                    .foregroundStyle(.tint)
                    .fontWeight(.bold)
            }
            
            Image(systemName: "xmark")
                .foregroundStyle(.gray)
            
        }.padding(10)
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
        
    }
}


//Round image Size
extension UpdatesScreenTabItem{
    enum constant {
        static let imageSize: CGFloat = 55
    }
}

//MyStatus
private struct MyStatusSection: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width: UpdatesScreenTabItem.constant.imageSize)
            VStack(alignment:.leading){
                Text("Sushant Dhakal")
                    .font(.callout)
                    .fontWeight(.bold)
                Text("Add to my Status")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            cameraButton()
            pencilButton()
            
            
            
        }
    }
    
    //Buttons
    
    private func cameraButton() -> some View {
        Button{
            
        }label:{
            Image(systemName: "camera.fill")
                .foregroundStyle(.black)
                .bold()
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(.circle)
            
        }
        
    }
    
    private func pencilButton() -> some View {
        Button{
            
        }label:{
            Image(systemName: "pencil")
                .foregroundStyle(.black)
                .bold()

                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(.circle)
            
        }
        
    }
}

private struct RecentStatusSection: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width: UpdatesScreenTabItem.constant.imageSize)
            VStack(alignment:.leading){
                Text("Sushant Dhakal")
                    .font(.callout)
                    .fontWeight(.bold)
                Text("1h ago")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
            
        }
    }
}


private struct ChannelSection: View {
    var body: some View {
        VStack(alignment:.leading){
            Text("Stay on topics that matters to you, Find channels to follow below")
                .font(.callout)
                .foregroundStyle(.gray)
                .padding(.horizontal)
            
            
            ScrollView(.horizontal){
                HStack {
                    ForEach(0..<5){_ in
                        ChannelListItem()
                        
                        
                    }
                    
                }
            }.scrollIndicators(ScrollIndicatorVisibility.hidden)
            
            Button("Explore more"){
                
                
                
                
                
            }.padding()
                .bold()
                .tint(.blue)
                .buttonStyle(.borderedProminent)
                .clipped()
            
            
            
            
        }
    }
}



struct ChannelListItem: View {
    var body: some View {
        VStack(alignment:.leading){
            Circle()
                .frame(width: UpdatesScreenTabItem.constant.imageSize)
            Text("Real Madrid C.F")
                .font(.callout)
            
            Button{
                
            }label:{
                Text("Follow")
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.2))
                    .clipShape(Capsule())
                
            }
        }.padding(.horizontal,16)
            .padding(.vertical)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray , lineWidth: 1)
                
            )
        
        
        
        
        
        
    }
}

struct ChannelSectionHeader: View {
    var body: some View {
        HStack{
            Text("Channels")
                .font(.title3)
                .foregroundStyle(.black)
                .bold()
                .textCase(nil)
            
            Spacer()
            
            Button{
                
            }label: {
                Image(systemName: "plus")
                    .padding(7)
                    .foregroundStyle(.black)
                    .background(Color(.systemGray5))
                    .clipShape(.circle)
            }
        }
    }
}


#Preview {
    UpdatesScreenTabItem()
}


