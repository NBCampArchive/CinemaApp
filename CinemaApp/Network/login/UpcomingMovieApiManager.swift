//
//  GetUpcomingMovies.swift
//  CinemaApp
//
//  Created by 유림 on 4/24/24.
//

import Foundation
class UpcomingMovieApiManager {
    
    var upcomingMovies: UpcomingMovies?
    
    // MARK: - Get Background Poster Image
    // Upcoming 1페이지에 있는 영화 중 랜덤 선택
    func fetchUpcomingMovie() {
        print("네트워크 통신 시작")
        // 1. url 생성
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "ko"),
          URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        // 2. URLRequest 생성
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": ""
        ]
        
        //
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // 3-1. 성공한 응답 걸러내기
            guard let httpResponse = response as? HTTPURLResponse, // URLResponse 타입인 response를 HTTPURLResponse 타입으로 바꾸기(http 요청이기 때문)
                  (200..<300).contains(httpResponse.statusCode) else {
                print("error: \(error)")
                return
            }
            
            // 3-2. 데이터 옵셔널 해제
            guard let data = data else { return }
            
            // 3-3. 디코딩
            do {
                let decoder = JSONDecoder()
                let upcomingMovies = try decoder.decode(UpcomingMovies.self, from: data) // 타입 자체를 가져올땐 .self
                self.upcomingMovies = upcomingMovies
            } catch let error as NSError {
                print("decoding error: \(error)")
            }
        }
        task.resume()

    }

    
}
