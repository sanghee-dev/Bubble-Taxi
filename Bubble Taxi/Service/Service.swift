//
//  Service.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/02.
//

import Firebase

struct Service {
    
    static let shared = Service()
    
    func fetchUserData(completion: @escaping(User) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(currentUid).observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            let user = User(dict: dict)

            completion(user)
        }
    }
}

