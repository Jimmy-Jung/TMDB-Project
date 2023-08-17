//
//  TMDBManager.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import Foundation
import Alamofire

final class TMDBNetworkManager {
    static let shared = TMDBNetworkManager()
    private init() {}
    
    func requestRecommendation(movieID: Int, completionHandler: @escaping ((_ data: MovieRecommendation) -> Void)) {
        let url =
    "https://api.themoviedb.org/3/movie/\(movieID)/recommendations"
        let headers: HTTPHeaders = [
          "accept": "application/json",
          "Authorization": APIKEY.TMDB_Acess_Token
        ]
        let parameters: Parameters = ["language": "ko"]
        AF.request(url, method: .get, parameters: parameters, headers: headers).validate(statusCode: 200...500).responseDecodable(of: MovieRecommendation.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestTrending(period: Period, completionHandler: @escaping (([MovieInfo]) -> Void)) {
        let url = TMDB_API.Trending.url(period: period)
        let headers: HTTPHeaders = [
          "accept": "application/json",
          "Authorization": APIKEY.TMDB_Acess_Token
        ]
        let parameters: Parameters = ["language": "ko"]
        AF.request(url, method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: Trending.self) { response in
            switch response.result {
            case .success(let value):
                guard let movieInfoList = value.results else {return}
                completionHandler(movieInfoList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestCredits(movieID: Int, completionHandler: @escaping ((Credits) -> Void)) {
        let url = TMDB_API.Credits.url(movieID: movieID)
        let headers: HTTPHeaders = [
          "accept": "application/json",
          "Authorization": APIKEY.TMDB_Acess_Token
        ]
        let parameters: Parameters = ["language": "ko"]
        AF.request(url, method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: Credits.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
