//
//  ViewModelManager.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-19.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class DatabaseManagerViewModel: ObservableObject {
    
    @Published var viewManagerModel: [Movie.MovieData] = []
    private var listener: ListenerRegistration?
    
    // Get the current user's UID
    private var currentUserId: String? {
        Auth.auth().currentUser?.uid
    }
    
    // Save to Firestore
    func addTofbfs(_ movie: Movie.MovieData, collectionName: String) {
        guard let userId = currentUserId else {
            print("No user is currently signed in.")
            return
        }
        
        do {
            let _ = try FirebaseConstants.db.collection("users").document(userId).collection(collectionName).document(String(movie.id)).setData(from: movie)
            print("Movie added to Firestore for user: \(userId)")
        } catch {
            print("Error adding to Firestore: \(error)")
        }
    }
    
    // Fetch from Firestore with real-time updates
    func fetchFromfsfb(collectionName: String) {
        guard let userId = currentUserId else {
            print("No user is currently signed in.")
            return
        }
        
        listener?.remove()
        listener = FirebaseConstants.db.collection("users").document(userId).collection(collectionName).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.viewManagerModel = documents.compactMap { doc in
                try? doc.data(as: Movie.MovieData.self)
            }
        }
    }
    
    // Delete a document from Firestore (user-specific)
    func deleteFromfbfs(id: String, collectionName: String) {
        guard let userId = currentUserId else {
            print("No user is currently signed in.")
            return
        }
        FirebaseConstants.db.collection("users").document(userId).collection(collectionName).document(id).delete { error in
            if let error = error {
                print("Error deleting data: \(error)")
            } else {
                print("Document deleted successfully for user: \(userId)")
            }
        }
    }
    
    // Delete all documents from Firestore (user-specific)
    func deleteAllFromfbfs(collectionName: CollectionNames) {
        guard let userId = currentUserId else {
            print("No user is currently signed in.")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection(collectionName.dataName).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents found for user: \(userId)")
                return
            }
            
            let batch = db.batch()
            
            for document in documents {
                let documentRef = db.collection("users").document(userId).collection(collectionName.dataName).document(document.documentID)
batch.deleteDocument(documentRef)
            }
            batch.commit { error in
                if let error = error {
                    print("Error committing batch: \(error.localizedDescription)")
                } else {
                    print("All documents deleted successfully for user: \(userId)")
                }
            }
        }
    }
    
    deinit {
        listener?.remove()
    }
}
