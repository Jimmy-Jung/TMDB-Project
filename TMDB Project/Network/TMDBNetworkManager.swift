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
    
    func requestTMDB<T: Decodable & TMDBResultType>(
        requestOption: TMDBRequestOption,
        metaType: T.Type,
        completionHandler: @escaping ((T) -> Void)
    ) {
        let url = requestOption.getURL
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKEY.TMDB_Acess_Token
        ]
        let parameters: Parameters = ["language": "ko"]
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: metaType) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
