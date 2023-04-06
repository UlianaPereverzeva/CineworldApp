//
//  Favoriteslist.swift
//  CineworldApp
//
//  Created by ульяна on 4.04.23.
//

import Foundation
import UIKit
import RealmSwift

class Favoriteslist: Object {
    
    @objc dynamic var id : String = UUID().uuidString

    @objc dynamic var name = ""
    @objc dynamic var poster = NSData()
    //@objc dynamic var isfavorite = true
    override class func primaryKey() -> String? {
        return "name"
    }
}

