//
//  ActorModel.swift
//  CineworldApp
//
//  Created by ульяна on 2.04.23.
//

import Foundation

//struct ArrayActorModel : Decodable {
//    let actorModel : [ActorModel]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case actorModel = "actorModel"
//    }
//}

struct ActorModel : Codable {
    let staffId : Int?
    let nameRu : String?
    let nameEn : String?
    let description : String?
    let posterUrl : String?
    let professionText : String?
    let professionKey : String?

    enum CodingKeys: String, CodingKey {

        case staffId = "staffId"
        case nameRu = "nameRu"
        case nameEn = "nameEn"
        case description = "description"
        case posterUrl = "posterUrl"
        case professionText = "professionText"
        case professionKey = "professionKey"
    }
}
