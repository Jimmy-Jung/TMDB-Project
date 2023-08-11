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
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalTitle, overview, posterPath: String?
    let mediaType: MediaType?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?
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
