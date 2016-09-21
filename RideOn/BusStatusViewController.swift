//
//  BusStatusViewController.swift
//  RideOn
//
//  Created by Karen on 9/21/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import UIKit
import MapKit

class BusStatusViewController: UIViewController {

    var userLocation = Location()
    let regionRadius: CLLocationDistance = 400
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidAppear(animated: Bool) {
        let alertController = UIAlertController(title: "RideOn", message: "Your Bus is arriving in 8 minutes at Morewood opp Forbes Ave.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLocation.getCurrentLocation()
        let initialLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        centerMapOnLocation(initialLocation)
        
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
