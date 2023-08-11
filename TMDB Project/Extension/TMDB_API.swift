//
//  URL+Extension.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import Foundation

enum TMDB_API {
    //    Trending: "https://api.themoviedb.org/3/trending/movie/\(period)?"
    //    Credits: "https://api.themoviedb.org/3/movie/\(movieID)/credits"
    static private let baseURL = "https://api.themoviedb.org/3/"
    
    enum Trending {
        static func url(period: Period) -> String {
            return TMDB_API.baseURL + "trending/movie/\(period.rawValue)?"
        }
    }
    enum Credits {
        static func url(movieID: Int) -> String {
            return TMDB_API.baseURL + "movie/\(movieID)/credits?"
        }
    }
}