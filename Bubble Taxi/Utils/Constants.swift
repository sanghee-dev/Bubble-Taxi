//
//  Constants.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/03.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

let KEY_USERNAME = "username"
let KEY_EMAIL = "email"
let KEY_ACCOUNTTYPE = "accountType"
