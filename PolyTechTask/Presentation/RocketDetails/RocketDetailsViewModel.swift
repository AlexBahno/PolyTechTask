//
//  RocketDetailsViewModel.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 10.04.2024.
//

import Foundation
import Combine

final class RocketDetailsViewModel: ObservableObject {
    
    var rocket: Rocket
    
    @Published private(set) var launches: [Launch] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isNoLaunches = false
    
    init(rocket: Rocket) {
        self.rocket = rocket
    }
    
    func fetchLaunches() {
        if isLoading {
            return
        }
        isLoading = true
        NetworkManager.shared.getLaunches(by: rocket.rocketID ?? "") { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let launches):
                self?.launches = launches
                if launches.count == 0 {
                    self?.isNoLaunches = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
