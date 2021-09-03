//
//  DriverAnnotation.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/03.
//

import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D) {
        self.uid = uid
        self.coordinate = coordinate
    }
    
}
