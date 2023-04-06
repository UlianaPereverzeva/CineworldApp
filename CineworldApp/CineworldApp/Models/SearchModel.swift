//
//  SearchModel.swift
//  CineworldApp
//
//  Created by ульяна on 5.04.23.
//

import Foundation

struct SearchModel : Codable {
    let keyword : String?
    let pagesCount : Int?
    let films : [Films]?
    let searchFilmsCountResult : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case keyword = "keyword"
        case pagesCount = "pagesCount"
        case films = "films"
        case searchFilmsCountResult = "searchFilmsCountResult"
    }
}
struct Films : Codable {
    let filmId : Int?
    let nameRu : String?
    let type : String?
    let year : String?
    let description : String?
    let filmLength : String?
    let countries : [Countries]?
    let genre : [Genre]?
    let rating : String?
    let ratingVoteCount : Int?
    let posterUrl : String?
    let posterUrlPreview : String?

    enum CodingKeys: String, CodingKey {

        case filmId = "filmId"
        case nameRu = "nameRu"
        case type = "type"
        case year = "year"
        case description = "description"
        case filmLength = "filmLength"
        case countries = "countries"
        case genre = "genre"
        case rating = "rating"
        case ratingVoteCount = "ratingVoteCount"
        case posterUrl = "posterUrl"
        case posterUrlPreview = "posterUrlPreview"
    }
}
