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

struct MyGenre {
    let id: Int
    let name: String
}

enum GenreType: String, CaseIterable {
    case all = "전체"
    case ani = "애니메이션"
    case comedy = "코미디"
    case fantasy = "판타지"
    case thiller = "스릴러"
    case action = "액션"
}
