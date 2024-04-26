//
//  Reservation.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/26/24.
//

import Foundation

struct Reservation: Codable {
    let movieId: Int
    let movieTitle: String
    let posterPath: String?
    let people: Int
    let price: Int
    let date: Date
}
