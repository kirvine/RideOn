//
//  Location.swift
//  RideOn
//
//  Created by Karen on 9/21/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import Foundation
import CoreLocation
class Location: NSObject, NSCoding  {
    
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var locationManager = CLLocationManager()
    
    override init() {
        self.latitude = 0.00
        self.longitude = 0.00
        super.init()
    }
    
    func getCurrentLocation() {
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        if let currLocation = locationManager.location {
            self.latitude = currLocation.coordinate.latitude
            self.longitude = currLocation.coordinate.longitude
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        self.latitude = aDecoder.decodeDoubleForKey("Latitude") as CLLocationDegrees
        self.longitude = aDecoder.decodeDoubleForKey("Longitude") as CLLocationDegrees
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(self.latitude, forKey: "Latitude")
        aCoder.encodeDouble(self.longitude, forKey: "Longitude")
    }
    
}
