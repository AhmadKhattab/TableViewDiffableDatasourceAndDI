//
//  Movie.swift
//  MoviesDiffableDataSource
//
//  Created by Ahmad Khattab on 20/06/2021.
//

import Foundation

struct Movie: Hashable, Decodable {
    var title: String?
    var image: String?
    var rating: Double?
    var releaseYear: Int?
    var genre: [String]?
}
