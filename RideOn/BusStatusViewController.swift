//
//  BusStatusViewController.swift
//  RideOn
//
//  Created by Karen on 9/21/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import UIKit
import MapKit

class BusStatusViewController: UIViewController, MKMapViewDelegate {

    var userLocation = Location()
    let regionRadius: CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidAppear(animated: Bool) {
        // alert message
//        let alertController = UIAlertController(title: "RideOn", message: "Your Bus is arriving in 8 minutes at Morewood opp Forbes Ave.", preferredStyle: UIAlertControllerStyle.Alert)
//        
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//        self.presentViewController(alertController, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // get current location
        userLocation.getCurrentLocation()
        let initialLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        centerMapOnLocation(initialLocation)
        
        // place pins of start and end locations
        let startLocation = CLLocationCoordinate2D(latitude: 40.4434658, longitude: -79.9456507)
        let endLocation = CLLocationCoordinate2D(latitude: 40.444284, longitude: -79.929416)
        
        let startPlacemark = MKPlacemark(coordinate: startLocation, addressDictionary: nil)
        let endPlacemark = MKPlacemark(coordinate: endLocation, addressDictionary: nil)
        
        let startMapItem = MKMapItem(placemark: startPlacemark)
        let endMapItem = MKMapItem(placemark: endPlacemark)
        
        // create annotations
        let startAnnotation = MKPointAnnotation()
        startAnnotation.title = "Start"
        let endAnnotation = MKPointAnnotation()
        endAnnotation.title = "End"
        
        if let location = startPlacemark.location {
            startAnnotation.coordinate = location.coordinate
        }
    
        if let location = endPlacemark.location {
            endAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([endAnnotation, startAnnotation], animated: true )
        
        // request directions
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = startMapItem
        directionRequest.destination = endMapItem
        directionRequest.transportType = .Automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            // establish routes
            let route = response.routes[0]
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }

    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 0.3098, green: 0.6784, blue: 0.9882, alpha: 1.0)
        renderer.lineWidth = 4.0
    
        return renderer
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 4.0, regionRadius * 4.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
