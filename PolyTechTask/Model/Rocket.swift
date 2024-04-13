//
//  Rocket.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 09.04.2024.
//

import Foundation

struct Rocket: Codable, Identifiable {
    let id: Int?
    let stages, costPerLaunch, successRatePct: Int?
    let firstFlight, country, company: String?
    let height, diameter: Diameter?
    let mass: Mass?
    let payloadWeights: [PayloadWeight]?
    let flickrImages: [String]?
    let wikipedia: String?
    let description, rocketID, rocketName, rocketType: String?

    enum CodingKeys: String, CodingKey {
        case id, stages
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, height, diameter, mass
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case wikipedia, description
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters: Double?
}

// MARK: - Mass
struct Mass: Codable {
    let kg, lb: Int?
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let id, name: String?
    let kg, lb: Int?
}
