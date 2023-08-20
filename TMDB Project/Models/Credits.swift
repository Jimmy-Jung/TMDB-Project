//
//  Credits.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import Foundation

// MARK: - Credits
struct Credits: Codable, TMDBResultType {
    let id: Int?
    let cast, crew: [Cast]?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let known_for_department: String?
    let name, original_name: String?
    let popularity: Double?
    let profile_path: String?
    let cast_id: Int?
    let character, credit_id: String?
    let order: Int?
    let department: String?
    let job: String?
}

