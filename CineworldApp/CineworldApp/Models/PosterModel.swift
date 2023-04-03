//
//  PosterModel.swift
//  CineworldApp
//
//  Created by ульяна on 29.03.23.
//

import Foundation

struct Posters: Decodable {
    let total: Int
    let totalPages: Int
    let items: [Item]
}

struct Item: Decodable {
    let imageUrl: String?
    let previewUrl: String?
}
