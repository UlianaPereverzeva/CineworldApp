//
//  ApiConstans.swift
//  CineworldApp
//
//  Created by ульяна on 28.03.23.
//

import Foundation

class ApiConstans {
    
    static let serverPath = "https://kinopoiskapiunofficial.tech"
    
    static let premieresPath = serverPath + "/api/v2.2/films/premieres" //?year=2023&month=OCTOBER
    static let premieresPathURL = URL(string: premieresPath)
    
    static let postersPath = serverPath + "/api/v2.2/films/" //"{id}/images?type=POSTER"
    
    static let nameOfFilmPath = serverPath + "/api/v2.2/films/" // 1
    
    static let logoOfFilmPath = serverPath + "/api/v2.2/films/" // 1
    
    static let ratingOfFilmPath = serverPath + "/api/v2.2/films/" // 1
    
    static let filmFiltersPath = serverPath + "/api/v2.2/films/filters"

    static let filmByFiltersPath = serverPath + "/api/v2.2/films" //?genres=1&order=RATING&type=FILM&ratingFrom=7&ratingTo=10&page=1
    static let videoPath = serverPath + "/api/v2.2/films/" //{id}/videos
    
    static let actorPath = serverPath + "/api/v1/staff?filmId=" //688

    static let searchPath = serverPath + "/api/v2.1/films/search-by-keyword?keyword=" //harry
}
