//
//  User.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/03.
//

import Foundation

struct User {
    let username: String
    let email: String
    let accountType: Int
    
    init(dict: [String: Any]) {
        self.username = dict[KEY_USERNAME] as? String ?? ""
        self.email = dict[KEY_EMAIL] as? String ?? ""
        self.accountType = dict[KEY_ACCOUNTTYPE] as? Int ?? 0
    }
}
