//
//  CallScreenTabItem.swift
//  WhatsAppClone
//
//  Created by Sushant Dhakal on 2025-01-27.
//

import SwiftUI

struct CallScreenTabItem: View {
    

    @State private var searchText = ""
    @State private var callsSelected = CallHistory.all
    
    
    var body: some View {
        NavigationStack{
            List{
                
                CreateLinkSection()
                
                Section{
                    RecentCallScreen()

                }header:{
                    Text("Recent")
                        .font(.headline)
                        .textCase(nil)
                        .foregroundStyle(.black)
                        .bold()
                    
                }
                
                
            }.navigationTitle("Calls")
                .searchable(text: $searchText)
                .toolbar{
                    topLeadingBarItem()
                    topTrailingBarItem()
                    topPrincipalItem()
                    
                    
                }
        }
    }
}


extension CallScreenTabItem {
    
    @ToolbarContentBuilder
    private func topLeadingBarItem() -> some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            Button("Edit"){
                
            }
        }
    }
    
    @ToolbarContentBuilder
    private func topTrailingBarItem() -> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                
            } label:{
                Image(systemName: "phone.arrow.up.right")
            }
        }
        
    }
    
    @ToolbarContentBuilder
    private func topPrincipalItem() -> some ToolbarContent{
        ToolbarItem(placement: .principal) {
            Picker("", selection:$callsSelected) {
                ForEach(CallHistory.allCases){ callItem in
                    Text(callItem.rawValue.capitalized)
                        .tag(callItem)
                }
            }.pickerStyle(.segmented)
                .frame(width: 150)

        }
        
       
        
    }
    
    private enum CallHistory:String,Identifiable, CaseIterable {
        case all, missed
        
        var id: String {
            return rawValue
        }
    }
    
}

private struct CreateLinkSection : View {
    var body: some View {
        HStack{
            Image(systemName: "link")
                .foregroundStyle(.blue)
                .padding(8)
                .background(Color(.systemGray6))
                .clipShape(Circle())
            VStack(alignment:.leading){
                Text("Create Call Link")
                    .foregroundStyle(.blue)
                Text("Share a link for your WhatsApp call")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                
            }
        }
    }
}

private struct RecentCallScreen:View {
    var body: some View {
        
            ForEach(0..<12){_ in
                HStack{
                Circle()
                    .frame(height: 50)
                
                VStack(alignment: .leading){
                    Text("Sushant Dhakal")
                        .font(.callout)
                        .bold()
                    
                    HStack(spacing: 4){
                        Image(systemName: "phone.arrow.up.right.fill")
                        Text("Outgoing")
                            .font(.system(size: 14))
                    } .foregroundStyle(.gray)
                    
                    
                    
                }
                
                Spacer()
                
                HStack{
                    Text("Yesterday")
                        .foregroundStyle(.gray)
                    Image(systemName: "info.circle")
                }
                
            }
        }
    }
}
#Preview {
    CallScreenTabItem()
}
