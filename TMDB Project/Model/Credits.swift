//
//  Credits.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import Foundation

// MARK: - Credits
struct Credits: Codable {
    let id: Int?
    let cast, crew: [Cast]?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: Department?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department: Department?
    let job: String?
}

enum Department: String, Codable {
    case acting
    case art
    case camera
    case costumeMakeUp
    case crew
    case directing
    case editing
    case lighting
    case production
    case sound
    case visualEffects
    case writing
}
