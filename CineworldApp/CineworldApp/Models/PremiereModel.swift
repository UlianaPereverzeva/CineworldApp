//
//  Premieres.swift
//  CineworldApp
//
//  Created by ульяна on 29.03.23.
//

import Foundation

struct Films : Codable {
    let total : Int?
    let items : [Items]?
    
    enum CodingKeys: String, CodingKey {

        case total = "total"
        case items = "items"
    }
}

struct Items : Codable {
    let kinopoiskId : Int?
    let nameRu : String?
    let year : Int?
    let posterUrl : String?
    let posterUrlPreview : String?
    let countries : [Countries]?
    let genres : [Genre]?
    let duration : Int?
    let premiereRu : String?
    let imdbId : String?
    let ratingKinopoisk : Double?
    let ratingImdb : Double?
    let type : String?
    
    let url : String?
    let name : String?
    let site : String?

    
    enum CodingKeys: String, CodingKey {

        case kinopoiskId = "kinopoiskId"
        case nameRu = "nameRu"
        case year = "year"
        case posterUrl = "posterUrl"
        case posterUrlPreview = "posterUrlPreview"
        case countries = "countries"
        case genres = "genres"
        case duration = "duration"
        case premiereRu = "premiereRu"
        case imdbId = "imdbId"
        case ratingKinopoisk = "ratingKinopoisk"
        case ratingImdb = "ratingImdb"
        case type = "type"
        case url = "url"
        case name = "name"
        case site = "site"

    }
}

