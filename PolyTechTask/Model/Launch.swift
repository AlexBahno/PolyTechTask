//
//  Launch.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 09.04.2024.
//

import Foundation

// MARK: - Launch
struct Launch: Codable, Identifiable {
    let id = UUID()
    let flightNumber: Int?
    let missionName: String?
    let launchDate: String?
    let launchSuccess: Bool?
    let links: Links?
    let details: String?
    let staticFireDateUTC: String?

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchDate = "launch_date_utc"
        case launchSuccess = "launch_success"
        case links, details
        case staticFireDateUTC = "static_fire_date_utc"
    }
}

// MARK: - Links
struct Links: Codable {
    let missionPatch, missionPatchSmall: String?
    let articleLink, wikipedia, videoLink: String?
    let flickrImages: [String]?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case flickrImages = "flickr_images"
    }
}
