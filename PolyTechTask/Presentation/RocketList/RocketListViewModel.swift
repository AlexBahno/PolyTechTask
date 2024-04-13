//
//  RocketListViewModel.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 10.04.2024.
//

import Foundation
import Combine

final class RocketListViewModel {
    
    @Published private(set) var rockets: [Rocket] = []
    @Published private(set) var isLoading = false
    
    func fetchRockets() {
        if isLoading {
            return 
        }
        self.isLoading = true
        NetworkManager.shared.getRockets { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let rockets):
                self?.rockets = rockets
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
