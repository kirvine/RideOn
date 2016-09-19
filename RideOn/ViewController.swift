//
//  ViewController.swift
//  RideOn
//
//  Created by Karen on 9/11/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    var directionsURL = NSURL(string: "")
    
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var arrivalField: UITextField!
    @IBOutlet weak var alertField: UITextField!
    
    @IBAction func queryGoogle(sender: AnyObject) {
        formatRequestUrl()
        getDirectionDataFromAPIWithSuccess{ (directionsData) -> Void in
            let json = JSON(data: directionsData)
            var place1 = json["geocoded_waypoints"]
            print(place1)
        }

    }
    
    func formatRequestUrl() {
        if let start = startField?.text, let end = endField?.text {
            var newStart = start.stringByReplacingOccurrencesOfString(" ", withString: "+")
            var newEnd = end.stringByReplacingOccurrencesOfString(" ", withString: "+")
            let link = "https://maps.googleapis.com/maps/api/directions/json?origin=\(newStart)&destination=\(newEnd)&mode=transit&key=AIzaSyAuIqvOjVysxuFCUGmcAtCUM14xV5SZB7U"
            directionsURL = NSURL(string: link)
            print(directionsURL)
        
        } else {
            let formError = UIAlertController(title: "Error", message:
                "Please enter a start and end location.", preferredStyle: UIAlertControllerStyle.Alert)
            formError.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(formError, animated: true, completion: nil)
        }

    }
    
    func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let downloadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
            
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"google.com", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        downloadDataTask.resume()

    }
    
    func getDirectionDataFromAPIWithSuccess(success: ((directionsData: NSData!) -> Void)) {
        loadDataFromURL(directionsURL!, completion:{(data, error) -> Void in
            if let data = data {
                success(directionsData: data)
            }
        })
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

