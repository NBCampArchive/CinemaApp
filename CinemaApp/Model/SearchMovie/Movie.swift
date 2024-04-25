//
//  Movie.swift
//  CinemaApp
//
//  Created by YJ on 4/22/24.
//

import Foundation

struct Movies: Decodable {
    let page: Int
    let results: [Results]
    let total_pages: Int
    let total_results: Int
}

struct Results: Decodable {
    // let adult: Bool
    // let backdrop_path: String?
    let genre_ids: [Int]
    // let id: Int
    // let original_language: String
    // let original_title: String
    // let overview: String
    // let popularity: Double
    let poster_path: String?
    // let release_date: String
    let title: String
    // let video: Bool
    // let vote_average: Double
    // let vote_count: Int
}
