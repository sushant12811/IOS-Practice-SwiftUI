//
//  Store.swift
//  HpTrivia
//
//  Created by Sushant Dhakal on 2025-01-21.
//
import Foundation
import StoreKit

enum BookStatus: Codable {
    case active
    case inactive
    case locked
}

@MainActor
class Store: ObservableObject{
    
    @Published var book: [BookStatus] = [.active, .active, .inactive, .locked, .locked,.locked, .locked]
    @Published var products: [Product] = []
    @Published var purchasedIDs = Set<String>()

    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    private var updates: Task<Void, Never>?
    private let savepath = FileManager.documentDirectory.appending(path: "saveBookStatus")

    
    init(){
        updates = watchForUpdates()
    }
    
    
    // load products
    func loadProducts() async {
        do{
            products = try await Product.products(for: productIDs)
            products.sort {$0.displayName < $1.displayName}

        }catch{
            print ("Error fetching products \(error)")
        }
    }
    
    
    // Purchased the product
    func purchased(_ product: Product) async{
        do{
            let result = try await product.purchase()
            
            switch result {
                
            case .success(let verificationResult):
                switch verificationResult {
                case .unverified(let signedType, let verificationError):
                    print("Error on \(signedType): \(verificationError)")
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                }
                
            case .userCancelled:
                break
            case .pending:
                break
            @unknown default:
                break
            }
        }catch{
            print("Could not purchased: \(error)")
        }
    }
    
    
    func loadStatus(){
        do{
            let data = try Data(contentsOf: savepath)
            book = try JSONDecoder().decode([BookStatus].self, from: data)
        }catch{
            print ("unable to load status")
        }
    }
    
    
   func saveStatus(){
        do{
            let data = try JSONEncoder().encode(book)
            try data.write(to: savepath)
            
        }catch{
            print("unable to save status")
        }
    }

    
    private func checkPurchased() async{
        for product in products {
            guard let state = await product.currentEntitlement else {return}
            
            switch state {
            case .unverified(let signedType, let verificationError):
                print("Error on \(signedType): \(verificationError)")

            case .verified(let signedType):
                if signedType.revocationDate == nil {
                    purchasedIDs.insert(signedType.productID)

                }else{
                    purchasedIDs.remove(signedType.productID)
                }

            }
        }
        
    }
  
    
    private func watchForUpdates() -> Task<Void, Never>{
        Task(priority: .background) {
            for await _ in Transaction.updates{
                await checkPurchased()
            }
            
        }
    }
    
}
