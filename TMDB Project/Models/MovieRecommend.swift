//
//  MovieRecommend.swift
//  SeSAC3Week5
//
//  Created by 정준영 on 2023/08/17.
//

import Foundation

// MARK: - MovieRecommend
struct MovieRecommendation: Codable {
    let page: Int?
    let results: [MovieInfo]
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}



