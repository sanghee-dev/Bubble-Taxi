//
//  User.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/03.
//

import CoreLocation

struct User {
    let uid: String
    let username: String
    let email: String
    let accountType: Int
    var location: CLLocation?
    
    init(uid: String, dict: [String: Any]) {
        self.uid = uid
        self.username = dict[KEY_USERNAME] as? String ?? ""
        self.email = dict[KEY_EMAIL] as? String ?? ""
        self.accountType = dict[KEY_ACCOUNTTYPE] as? Int ?? 0
    }
}
