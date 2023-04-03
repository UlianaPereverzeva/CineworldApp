//
//  VideoModel.swift
//  CineworldApp
//
//  Created by ульяна on 1.04.23.
//

import Foundation

struct VideoModel : Codable {
    
    let total : Int?
    let items : [Items]?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case items = "items"
    }
}

//struct Items : Codable {
//    let url : String?
//    let name : String?
//    let site : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case url = "url"
//        case name = "name"
//        case site = "site"
//    }
//}
