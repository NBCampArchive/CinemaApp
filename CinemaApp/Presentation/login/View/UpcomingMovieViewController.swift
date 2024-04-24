//
//  UpcomingMovieViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/24/24.
//

import UIKit

class UpcomingMovieViewController: LoginViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Get Background Poster Image
    // Upcoming 1페이지에 있는 영화 중 랜덤 선택
//    func getUpcomingMovie() {
//
//        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        let queryItems: [URLQueryItem] = [
//          URLQueryItem(name: "language", value: "en-US"),
//          URLQueryItem(name: "page", value: "1"),
//        ]
//        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//
//        var request = URLRequest(url: components.url!)
//        request.httpMethod = "GET"
//        request.timeoutInterval = 10
//        request.allHTTPHeaderFields = [
//          "accept": "application/json",
//          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMzFiOWM1ZTU4OTljNzdhNTc0M2RhMWY1OGU0NjE3MSIsInN1YiI6IjY2MjVkMGZkY2I1YzhlMDE2NDNmY2Y2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gYBA_5m1zFie_AKPbNap-9XH1IHCjHgMHw5hP1T1H_k"
//        ]
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//        print(String(decoding: data, as: UTF8.self))
//    }

}
