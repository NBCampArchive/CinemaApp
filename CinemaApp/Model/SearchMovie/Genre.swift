//
//  Genre.swift
//  CinemaApp
//
//  Created by YJ on 4/25/24.
//

import Foundation

struct GenresMovieList: Decodable {
    let genres: [Genres]
}

struct Genres: Decodable {
    let id: Int?
    let name: String?
}
