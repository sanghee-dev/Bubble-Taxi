//
//  Service.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/02.
//

import Firebase
import CoreLocation
import GeoFire

struct Service {
    
    static let shared = Service()
    
    // uid -> user
    func fetchUserData(uid: String, completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            let uid = snapshot.key
            let user = User(uid: uid, dict: dict)
            completion(user)
        }
    }
    
    // location -> nearby drivers
    func fetchDrivers(location: CLLocation, completion: @escaping(User) -> Void) {
        let geoFire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
        
        REF_DRIVER_LOCATIONS.observe(.value) { snapshot in
            geoFire.query(at: location, withRadius: 50).observe(.keyEntered, with: { (uid, location) in
                self.fetchUserData(uid: uid) { user in
                    var driver = user
                    driver.location = location
                    completion(driver)
                }
            })
        }
    }
}
