//
//  NetworkManager.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 09.04.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case cannnotParseData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let rocketCache = Cache<String, [Rocket]>()
    private let launchesCache = Cache<String, [Launch]>()
    
    private init() {}
    
    func getRockets(_ completion: @escaping (Result<[Rocket], Error>) -> Void) {
        let url = NetworkConstants.baseURL + RequestTopic.rockets.rawValue
        AF.request(url)
            .validate()
            .response { [weak self] response in
                guard let data = response.data else {
                    if let error = response.error {
                        if let cached = try? self?.rocketCache.getFromDisk(withName: SavingName.rockets.rawValue) {
                            return completion(.success(cached))
                        }
                        completion(.failure(error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                let result = try? decoder.decode([Rocket].self, from: data)
                guard let result = result else {
                    completion(.failure(NetworkError.cannnotParseData))
                    return
                }
                self?.rocketCache[SavingName.rockets.rawValue] = result
                try? self?.rocketCache.saveToDisk(withName: SavingName.rockets.rawValue, d: result)
                completion(.success(result))
            }
    }
    
    func getLaunches(by rocketId: String,
                     _ completion: @escaping (Result<[Launch], Error>) -> Void) {
        let url = NetworkConstants.baseURL + RequestTopic.launches.rawValue + "?rocket_id=" + rocketId
        AF.request(url)
            .validate()
            .response { [weak self] response in
                guard let data = response.data else {
                    if let error = response.error {
                        if let cached = try? self?.launchesCache.getFromDisk(withName: rocketId) {
                            return completion(.success(cached))
                        }
                        completion(.failure(error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                let result = try? decoder.decode([Launch].self, from: data)
                guard let result = result else {
                    completion(.failure(NetworkError.cannnotParseData))
                    return
                }
                self?.launchesCache[rocketId] = result
                try? self?.launchesCache.saveToDisk(withName: rocketId, d: result)
                completion(.success(result))
            }
    }
}

enum SavingName: String {
    case rockets = "Rockets"
}
