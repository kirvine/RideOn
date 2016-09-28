//
//  BusStatusViewController.swift
//  RideOn
//
//  Created by Karen on 9/21/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class BusStatusViewController: UIViewController, MKMapViewDelegate {

    var userLocation = Location()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var leaveTimeLabel: UILabel!
    @IBOutlet weak var busETALabel: UILabel!
    @IBOutlet weak var alertTimeLabel: UILabel!
    
    @IBAction func showAlert(sender: AnyObject) {
        let arrivalTime = getBusArrivalTime()
        // alert message
        let alertController = UIAlertController(title: "RideOn", message: "Leave in 10 min to catch the 69 at \(arrivalTime) pm!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func getBusArrivalTime() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([.Hour, .Minute], fromDate: date as NSDate)
        var hour = Int(components.hour) % 12
        var min = Int(components.minute) + 16
        if min/60 > 0 {
            hour += 1
            min = min % 60
        }
        
        return String(format: "%02d:%02d", hour, min)
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        mapView.delegate = self
        userLocation.getCurrentLocation()

        // create MapKit objects for start and end locations
        let startLocation = CLLocationCoordinate2D(latitude: 40.444545, longitude: -79.9447229)
        let endLocation = CLLocationCoordinate2D(latitude: 40.444257, longitude: -79.927176)
        let busLocation = CLLocationCoordinate2D(latitude: 40.439022306411985, longitude: -80.00376238141742)

        let startPlacemark = MKPlacemark(coordinate: startLocation, addressDictionary: nil)
        let endPlacemark = MKPlacemark(coordinate: endLocation, addressDictionary: nil)
        let busPlacemark = MKPlacemark(coordinate: busLocation, addressDictionary: nil)
        
        let startMapItem = MKMapItem(placemark: startPlacemark)
        let endMapItem = MKMapItem(placemark: endPlacemark)
        
        placeAnnotations([startPlacemark, endPlacemark, busPlacemark])
        requestDirections(startMapItem, endMapItem: endMapItem)
    
    }

    func placeAnnotations(pins: [MKPlacemark]) {
        // create annotations
        let startAnnotation = MKPointAnnotation()
        startAnnotation.title = "Start"
        startAnnotation.coordinate = pins[0].coordinate
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.title = "End"
        endAnnotation.coordinate = pins[1].coordinate
        
        let busAnnotation = MKPointAnnotation()
        busAnnotation.title = "69"
        busAnnotation.coordinate = pins[2].coordinate
        
        self.mapView.showAnnotations([startAnnotation, endAnnotation, busAnnotation], animated: true )
    }
    
    func requestDirections(startMapItem: MKMapItem, endMapItem: MKMapItem) {
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

    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
