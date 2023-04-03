//
//  FilmModel.swift
//  CineworldApp
//
//  Created by ульяна on 22.03.23.
//

import Foundation

struct FilmModel : Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case kinopoiskId = "kinopoiskId"
        //        case imdbId = "imdbId"
        case nameRu = "nameRu"
        //        case nameEn = "nameEn"
        //        case nameOriginal = "nameOriginal"
        //        case posterUrl = "posterUrl"
        //        case posterUrlPreview = "posterUrlPreview"
        //        case coverUrl = "coverUrl"
        case logoUrl = "logoUrl"
        //        case reviewsCount = "reviewsCount"
        //        case ratingGoodReview = "ratingGoodReview"
        //        case ratingGoodReviewVoteCount = "ratingGoodReviewVoteCount"
        case ratingKinopoisk = "ratingKinopoisk"
        //        case ratingKinopoiskVoteCount = "ratingKinopoiskVoteCount"
        //        case ratingImdb = "ratingImdb"
        //        case ratingImdbVoteCount = "ratingImdbVoteCount"
        //        case ratingFilmCritics = "ratingFilmCritics"
        //        case ratingFilmCriticsVoteCount = "ratingFilmCriticsVoteCount"
        //        case ratingAwait = "ratingAwait"
        //        case ratingAwaitCount = "ratingAwaitCount"
        //        case ratingRfCritics = "ratingRfCritics"
        //        case ratingRfCriticsVoteCount = "ratingRfCriticsVoteCount"
        //        case webUrl = "webUrl"
        case year = "year"
        case filmLength = "filmLength"
        //        case slogan = "slogan"
        case description = "description"
        case shortDescription = "shortDescription"
        //        case editorAnnotation = "editorAnnotation"
        //        case isTicketsAvailable = "isTicketsAvailable"
        //        case productionStatus = "productionStatus"
        //        case type = "type"
        //        case ratingMpaa = "ratingMpaa"
        case ratingAgeLimits = "ratingAgeLimits"
        //        case hasImax = "hasImax"
        //        case has3D = "has3D"
        //        case lastSync = "lastSync"
        case countries = "countries"
        case genres = "genres"
        //        case startYear = "startYear"
        //        case endYear = "endYear"
        //        case serial = "serial"
        //        case shortFilm = "shortFilm"
        //        case completed = "completed"
    }
    let kinopoiskId : Int?
//    let imdbId : String?
    let nameRu : String?
//    let nameEn : String?
//    let nameOriginal : String?
//    let posterUrl : String?
//    let posterUrlPreview : String?
//    let coverUrl : String?
    let logoUrl : String?
//    let reviewsCount : Int?
//    let ratingGoodReview : Double?
//    let ratingGoodReviewVoteCount : Int?
    let ratingKinopoisk : Double?
//    let ratingKinopoiskVoteCount : Int?
//    let ratingImdb : Double?
//    let ratingImdbVoteCount : Int?
//    let ratingFilmCritics : Double?
//    let ratingFilmCriticsVoteCount : Int?
//    let ratingAwait : Double?
//    let ratingAwaitCount : Int?
//    let ratingRfCritics : Double?
//    let ratingRfCriticsVoteCount : Int?
//    let webUrl : String?
    let year : Int?
    let filmLength : Int?
//    let slogan : String?
    let description : String?
    let shortDescription : String?
//    let editorAnnotation : String?
//    let isTicketsAvailable : Bool?
//    let productionStatus : String?
//    let type : String?
//    let ratingMpaa : String?
    let ratingAgeLimits : String?
//    let hasImax : Bool?
//    let has3D : Bool?
//    let lastSync : String?
    let countries :  [Countries]
    let genres : [Genre]
//    let startYear : Int?
//    let endYear : Int?
//    let serial : Bool?
//    let shortFilm : Bool?
//    let completed : Bool?
    
}

struct Genre : Codable {
    let genre : String?
    let id : Int?

    enum CodingKeys: String, CodingKey {
        case genre = "genre"
        case id  = "id"
    }
}

struct Countries : Codable {
    let country : String?

    enum CodingKeys: String, CodingKey {
        case country = "country"
    }
}

struct Genres : Codable {
    
    let genres : [Genre]
    

}
