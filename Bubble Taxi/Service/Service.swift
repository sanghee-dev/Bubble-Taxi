//
//  Service.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/02.
//

import Firebase

struct Service {
    
    static let shared = Service()
    let currentUid = Auth.auth().currentUser?.uid
    
    func fetchUserData() {
        guard let currentUid = currentUid else { return }
        REF_USERS.child(currentUid).observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            guard let username = dict[KEY_USERNAME] as? String else { return }
            print(username)
        }
    }
    
}
