//
//  URL+Extension.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import Foundation

//    Trending: "https://api.themoviedb.org/3/trending/movie/\(period)?"
//    Credits: "https://api.themoviedb.org/3/movie/\(movieID)/credits"

enum TMDBRequestOption{
    private var baseURL: String { return "https://api.themoviedb.org/3/" }
    
    case trendings(Period)
    case credits(Int)
    case recommendation(Int)
    
    var getURL: String {
        switch self {
        case .trendings(let period):
            return baseURL + "trending/movie/\(period.rawValue)?"
        case .credits(let movieID):
            return baseURL + "movie/\(movieID)/credits?"
        case .recommendation(let movieID):
            return baseURL + "movie/\(movieID)/recommendations"
        }
    }
}

enum TMDB_API {
    
    static func imageURL(width: Int, path: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w\(width)\(path)")
    }
    static func imageURLString(width: Int, path: String) -> String {
        return "https://image.tmdb.org/t/p/w\(width)\(path)"
    }
    

}
