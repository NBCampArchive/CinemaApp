//
//  GetUpcomingMovies.swift
//  CinemaApp
//
//  Created by 유림 on 4/24/24.
//

//import Foundation
//import UIKit
//class UpcomingMovieApiManager {
//    
//    var upcomingMovies: UpcomingMovies? {
//        didSet {
//            getRandomUpcomingMovieData()
//        }
//    }
//    var posterImageURL: URL?
//    
//    // MARK: - 배경 포스터 설정하기
//    /* TODO: Upcoming 1페이지에 있는 영화 중 랜덤 선택
//     1. Upcoming Movies URL에서 1페이지 데이터를 upcomingMovies에 저장
//     2. upcomingMovies에서 영화 포스터 1개 랜덤 추출
//     3. 포스터 URL을 데이터화 */
//    
//    // MARK: 1. Upcoming Movies 1페이지 데이터를 upcomingMovies에 저장
//    func fetchUpcomingMovie() {
//        print("네트워크 통신 시작")
//        // 1. url 생성
//        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        let queryItems: [URLQueryItem] = [
//          URLQueryItem(name: "language", value: "ko"),
//          URLQueryItem(name: "page", value: "1"),
//        ]
//        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//        
//        // 2. URLRequest 생성
//        var request = URLRequest(url: components.url!)
//        request.httpMethod = "GET"
//        request.timeoutInterval = 10
//        request.allHTTPHeaderFields = [
//          "accept": "application/json",
//          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMzFiOWM1ZTU4OTljNzdhNTc0M2RhMWY1OGU0NjE3MSIsInN1YiI6IjY2MjVkMGZkY2I1YzhlMDE2NDNmY2Y2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gYBA_5m1zFie_AKPbNap-9XH1IHCjHgMHw5hP1T1H_k"
//        ]
//        
//        //
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // 3-1. 성공한 응답 걸러내기
//            guard let httpResponse = response as? HTTPURLResponse, // URLResponse 타입인 response를 HTTPURLResponse 타입으로 바꾸기(http 요청이기 때문)
//                  (200..<300).contains(httpResponse.statusCode) else {
//                print("error: \(error)")
//                return
//            }
//            
//            // 3-2. 데이터 옵셔널 해제
//            guard let data = data else { return }
//            
//            // 3-3. 디코딩
//            do {
//                let decoder = JSONDecoder()
//                let upcomingMovies = try decoder.decode(UpcomingMovies.self, from: data) // 타입 자체를 가져올땐 .self
//                self.upcomingMovies = upcomingMovies
//                print("upcomimgMovies 데이터 가져오기 성공")
//            } catch let error as NSError {
//                print("decoding error: \(error)")
//            }
//        }
//        task.resume()
//    }
//    
//    // MARK: - upcomingMovies에서 영화 포스터 이미지 1개 랜덤 추출
//    func getRandomUpcomingMovieData() {
//        guard let upcomingMovies = self.upcomingMovies?.results else { 
//            print("랜덤 이미지 추출 실패")
//            return }
//        let randomIndex = Int.random(in: 0..<upcomingMovies.count)
//        let targetMovie = upcomingMovies[randomIndex]
//        self.posterImageURL = URL(string: "https://image.tmdb.org/t/p/w500\( targetMovie.posterPath)")
//        print("posterURL: \(posterImageURL)")
//    }
//    
//}
