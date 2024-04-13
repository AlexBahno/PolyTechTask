//
//  NetworkConstants.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 09.04.2024.
//

import Foundation

struct NetworkConstants {
    static let baseURL = "https://api.spacexdata.com/v3/"
}

enum RequestTopic: String {
    case rockets = "rockets"
    case launches = "launches"
}
