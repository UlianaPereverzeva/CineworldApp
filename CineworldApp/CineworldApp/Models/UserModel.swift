//
//  UserModel.swift
//  CineworldApp
//
//  Created by ульяна on 17.02.23.
//

import Foundation
import Firebase

struct User {
    var uid: String
    var email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email ?? ""
    }
}
