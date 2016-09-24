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
    let regionRadius: CLLocationDistance = 500
    
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
        
        userLocation.getCurrentLocation()
        let initialLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        centerMapOnLocation(initialLocation)
        
        
        // 1.
        mapView.delegate = self
        
        // 2.
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.444284, longitude: -79.929416)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.4434658, longitude: -79.9456507)
        
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Start"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "End"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .Automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
//        // directions request
//        let request = MKDirectionsRequest()
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.444284, longitude: -79.929416), addressDictionary: nil))
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.4434658, longitude: -79.9456507), addressDictionary: nil))
//        request.requestsAlternateRoutes = false
//        request.transportType = MKDirectionsTransportType.Transit
//        
//        // draw direction route
//        let directions = MKDirections(request: request)
//        directions.calculateDirectionsWithCompletionHandler({ [unowned self] response, error in
//            guard let unwrappedResponse = response else { return }
//            
//            for route in unwrappedResponse.routes {
//                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
//                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//            }
//        }
//        )
//        
//    }

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 4.0
    
        return renderer
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 4.0, regionRadius * 4.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
