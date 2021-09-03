//
//  Constants.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/03.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_USER_LOCATIONS = DB_REF.child("user-locations")
let REF_DRIVER_LOCATIONS = DB_REF.child("driver-locations")

let KEY_USERNAME = "username"
let KEY_EMAIL = "email"
let KEY_ACCOUNTTYPE = "accountType"

let DRIVER_ANNOTATION = "DriverAnnotation"
