//
//  DeleteAll.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-21.
//

import SwiftUI

struct DeleteAll: View {
    @StateObject private var deleteModel = DatabaseManagerViewModel()
    @State var showDeleteAlert = false
    var collection: CollectionNames
    
    var body: some View {
        VStack{
            
        }
        .toolbar {
            deleteButton()
        
        }.deleteAlert(isPresented: $showDeleteAlert, collection: collection) {
            deleteModel.deleteAllFromfbfs(collectionName: collection)
        }
    }
    
    @ToolbarContentBuilder
    private func deleteButton() -> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                showDeleteAlert = true
            }label:{
                Image(systemName: "trash")
                    .imageScale(.large)
                    .foregroundStyle(.red)
            }
        }
    }
}

//Delete Confirmation ALert
struct DeleteConfirmationAlert: ViewModifier {
    @Binding var isPresented: Bool
    var collection: CollectionNames
    var onDelete: () -> Void

    func body(content: Content) -> some View {
        content.alert("Delete All", isPresented: $isPresented) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                onDelete()
            }
            
        }message: {
            Text( "Are you sure want to delete all?")
        }
    }
}

//Extension to reuse
extension View {
    func deleteAlert(isPresented: Binding<Bool>, collection: CollectionNames, onDelete: @escaping () -> Void) -> some View {
        self.modifier(DeleteConfirmationAlert(isPresented: isPresented, collection: collection, onDelete: onDelete))
    }
}

#Preview {
    DeleteAll( collection: .favourite)
}
