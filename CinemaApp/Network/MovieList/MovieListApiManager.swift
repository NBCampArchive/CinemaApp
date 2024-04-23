//
//  MovieListApiManager.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/22/24.
//

import Foundation
import Alamofire

class MovieListApiManager{
    // 싱글톤 객체 생성
    static let shared = MovieListApiManager()
    
    
    
    private init() {}
    
    func fetchMovieList(listType: String, page: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        let url = baseURL + listType
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "accept": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "language": "en-US",
            "page": page,
            "api_key": "\(apiKey)"
        ]
        
        AF.request(url, parameters: parameters, headers: headers).validate().responseDecodable(of: MovieListResponse.self) { response in
            switch response.result {
            case .success(let movieListResponse):
                completion(.success(movieListResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}