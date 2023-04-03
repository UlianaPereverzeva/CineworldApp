//
//  FilmFilterModel.swift
//  CineworldApp
//
//  Created by ульяна on 29.03.23.
//

import Foundation

struct FilmFilter : Codable {
    let total : Int?
    let totalPages : Int?
    let items : [Items]?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case totalPages = "totalPages"
        case items = "items"
    }
}


