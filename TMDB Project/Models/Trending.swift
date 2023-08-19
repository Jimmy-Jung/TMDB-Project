//
//  Trending.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import Foundation

protocol TMDBProtocol {}

// MARK: - Trending
struct Trending: Codable, TMDBProtocol {
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
    let originalLanguage: String?
    let originalTitle, overview: String?
    let posterPath: String?
    let mediaType: MediaType?
    let genreIDS: [Int]
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
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
