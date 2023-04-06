//
//  RealmManager.swift
//  CineworldApp
//
//  Created by ульяна on 5.04.23.
//

import Foundation

class RealmManager {
    
    static let shared = RealmManager()
    private let realmService = RealmService()
    
    private init() {
        
    }
    
    func objectExist(id: String) -> Bool {
        return realmService.localRealm.object(ofType: Favoriteslist.self, forPrimaryKey: id) != nil
    }
}
