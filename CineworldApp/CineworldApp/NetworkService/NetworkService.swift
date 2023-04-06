//
//  NetworkService.swift
//  CineworldApp
//
//  Created by ульяна on 22.03.23.
//

import UIKit
import Alamofire
import AlamofireImage
import Kingfisher


class NetworkService {
    
    static func fetchPosters(type: String, filmID: Int, callBack:  @escaping (Posters?, Error?) -> Void) {
        
        let url = "\(ApiConstans.postersPath)\(filmID)/images?type=\(type)"
        
        let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                       "Content-Type": "application/json"]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).response { response in
            
            var jsonValue: Posters?
            var err: Error?
            
            switch response.result {
            case.success(let data):
                guard let data = data else { return }
                do {
                    jsonValue = try JSONDecoder().decode(Posters.self, from: data)
                } catch {
                    err = error
                }
            case.failure(let error):
                err = error
            }
            callBack(jsonValue, err)
        }
    }

    
    
    static func fetchDataAboutFilm(filmID: Int, callBack: @escaping (FilmModel?, Error?) -> Void) {

        let url = "\(ApiConstans.nameOfFilmPath)\(filmID)"

        let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                       "Content-Type": "application/json"]

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).response { response in

            var jsonValue: FilmModel?
            var err: Error?

            switch response.result {
            case.success(let data):
                guard let data = data else { return }
                do {
                    jsonValue = try JSONDecoder().decode(FilmModel.self, from: data)
                } catch {
                    err = error
                }
            case.failure(let error):
                err = error
            }
            callBack(jsonValue, err)
        }
    }
    
    static func fetchLogoOfFilm(filmID: Int, callBack:  @escaping (FilmModel?, Error?) -> Void) {
        
//        let randomFilmForPoster = 658//Int.random(in: 1..<1999)//нужно сделать массив проверенных фильмов
        let url = "\(ApiConstans.logoOfFilmPath)\(filmID)"

        let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                       "Content-Type": "application/json"]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).response { response in
            
            var jsonValue: FilmModel?
            var err: Error?
            
            switch response.result {
            case.success(let data):
                guard let data = data else { return }
                do {
                    jsonValue = try JSONDecoder().decode(FilmModel.self, from: data)
                } catch {
                    err = error
                }
            case.failure(let error):
                err = error
            }
            callBack(jsonValue, err)
        }
    }
    
    static func fetchRatingOfFilm(filmID: Int, callBack: @escaping (FilmModel?, Error?) -> Void) {
    
            let url = "\(ApiConstans.nameOfFilmPath)\(filmID)"
    
            let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                           "Content-Type": "application/json"]
    
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).response { response in
    
                var jsonValue: FilmModel?
                var err: Error?
    
                switch response.result {
                case.success(let data):
                    guard let data = data else { return }
                    do {
                        jsonValue = try JSONDecoder().decode(FilmModel.self, from: data)
                    } catch {
                        err = error
                    }
                case.failure(let error):
                    err = error
                }
                callBack(jsonValue, err)
            }
        }
    
    static func fetchPosterByIdOfGenres(genresID: Int, callBack: @escaping (Film?, Error?) -> Void) {
    
        let url = "\(ApiConstans.filmByFiltersPath)?genres=\(genresID)&order=RATING&type=FILM&ratingFrom=7&ratingTo=10"
    
            let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                           "Content-Type": "application/json"]
    
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).response { response in
    
                var jsonValue: Film?
                var err: Error?
    
                switch response.result {
                case.success(let data):
                    guard let data = data else { return }
                    do {
                        jsonValue = try JSONDecoder().decode(Film.self, from: data)
                    } catch {
                        err = error
                    }
                case.failure(let error):
                    err = error
                }
                callBack(jsonValue, err)
            }
        }
    
    static func fetchArraysOfGenresAndCountries(callBack: @escaping (Genres?, Error?) -> Void) {
        
        let url = ApiConstans.filmFiltersPath
        
        let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                       "Content-Type": "application/json"]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).response { response in

            var jsonValue: Genres?
            var err: Error?

            switch response.result {
            case.success(let data):
                guard let data = data else { return }
                do {
                    jsonValue = try JSONDecoder().decode(Genres.self, from: data)
                } catch {
                    err = error
                }
            case.failure(let error):
                err = error
            }
            callBack(jsonValue, err)
        }
    }
    
    static func fetchVideo(filmID: Int, callBack: @escaping (VideoModel?, Error?) -> Void) {
        
        let url = "\(ApiConstans.videoPath)\(filmID)/videos"
        
        let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                       "Content-Type": "application/json"]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).response { response in

            var jsonValue: VideoModel?
            var err: Error?

            switch response.result {
            case.success(let data):
                guard let data = data else { return }
                do {
                    jsonValue = try JSONDecoder().decode(VideoModel.self, from: data)
                } catch {
                    err = error
                }
            case.failure(let error):
                err = error
            }
            callBack(jsonValue, err)
        }
    }
    
    static func fetchActors(filmID: Int, callBack: @escaping ([ActorModel]?, Error?) -> Void) {
        
        let url = "\(ApiConstans.actorPath)\(filmID)"
        
        let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                       "Content-Type": "application/json"]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).response { response in

            var jsonValue: [ActorModel]?
            var err: Error?

            switch response.result {
            case.success(let data):
                guard let data = data else { return }
                do {
                    jsonValue = try JSONDecoder().decode([ActorModel].self, from: data)
                } catch {
                    err = error
                }
            case.failure(let error):
                err = error
            }
            callBack(jsonValue, err)
        }
    }
    
    static func fetchFilmsBySearch(keyword: String, callBack: @escaping (SearchModel?, Error?) -> Void) {
        
        let url = ApiConstans.searchPath
        let parameters = ["keyword": keyword]
        let headers = ["X-API-KEY": "f926902b-4c3d-458f-92c5-206a685893aa",
                       "Content-Type": "application/json"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders(headers)).response { response in

            var jsonValue: SearchModel?
            var err: Error?

            switch response.result {
            case.success(let data):
                guard let data = data else { return }
                do {
                    jsonValue = try JSONDecoder().decode(SearchModel.self, from: data)
                } catch {
                    err = error
                }
            case.failure(let error):
                err = error
            }
            callBack(jsonValue, err)
        }

    }
}
