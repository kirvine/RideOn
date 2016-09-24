//
//  ViewController.swift
//  RideOn
//
//  Created by Karen on 9/11/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate {

    var directionsURL = NSURL(string: "")
    
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var arrivalField: UITextField!
    @IBOutlet weak var alertField: UITextField!

    @IBAction func sss(sender: AnyObject) {
        formatRequestUrl()
        getDirectionDataFromAPIWithSuccess{ (directionsData) -> Void in
            let json = JSON(data: directionsData)
            var lon = json["bustime-response"]["vehicle"][0]["lon"]
            var lat = json["bustime-response"]["vehicle"][0]["lat"]
            print(lon, lat)
        }
    }

    func formatRequestUrl() {
        print("we're in the formatRequestURL")
        let link = "http://realtime.portauthority.org/bustime/api/v1/getvehicles?key=6h9DEqXXar8PqdsyqF7wGecG8&rt=69&tmres=s&format=json"
        directionsURL = NSURL(string: link)
        print(directionsURL)
    }
    
    func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let downloadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
            
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"http://realtime.portauthority.org", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
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

