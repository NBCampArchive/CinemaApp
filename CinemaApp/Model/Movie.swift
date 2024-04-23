//
//  Movie.swift
//  CinemaApp
//
//  Created by YJ on 4/22/24.
//

import Foundation

struct Movie: Decodable {
    var page: Int
    var results: [Results]
    var total_pages: Int
    var total_results: Int
}

struct Results: Decodable {
    // var adult: Bool
    // var backdrop_path: String?
    // var genre_ids: [Int]
    // var id: Int
    // var original_language: String
    // var original_title: String
    // var overview: String
    // var popularity: Double
    var poster_path: String?
    // var release_date: String
    var title: String
    // var video: Bool
    // var vote_average: Double
    // var vote_count: Int
}
