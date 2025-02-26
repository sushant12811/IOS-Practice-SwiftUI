//
//  RootScreenModel.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-18.
//

import Foundation
import Combine

final class RootScreenModel: ObservableObject {
    @Published var authState: AuthState = .Pending
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        AuthManagerService.shared.authState.receive(on: DispatchQueue.main)

            .sink { [weak self] latestauthState in
                self?.authState = latestauthState
                print("RootScreenModel: authState updated to \(latestauthState)") // Debugging

                        }
            .store(in: &cancellable)

    }
}
