//
//  ViewController.swift
//  RideOn
//
//  Created by Karen on 9/11/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class ViewController: UIViewController, UISearchBarDelegate {

    var directionsURL = NSURL(string: "")
    
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var arrivalField: UITextField!
    @IBOutlet weak var alertField: UITextField!

    @IBAction func getDirections(sender: AnyObject) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.444284, longitude: -79.929416), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.4434658, longitude: -79.9456507), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = MKDirectionsTransportType.Transit
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

