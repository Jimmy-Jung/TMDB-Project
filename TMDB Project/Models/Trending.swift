//
//  Trending.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import Foundation

// MARK: - Credits
struct Trending: Codable {
    let page: Int?
    let results: [MovieInfo]?
    let totalPages, totalResults: Int?
}

// MARK: - Result
struct MovieInfo: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let title: String?
    let original_title, overview, poster_path: String?
    let media_type: MediaType?
    let genre_ids: [Int]?
    let popularity: Double?
    let release_date: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}

enum MediaType: String, Codable {
    case movie
    case tv
    case person
}

enum Period: String {
    case day
    case week
}
