//
//  DataManager.swift
//  RideOn
//
//  Created by Karen on 9/25/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import Foundation

let directionsURL = NSURL(string: "http://realtime.portauthority.org/bustime/api/v1/getvehicles?key=6h9DEqXXar8PqdsyqF7wGecG8&rt=69&tmres=s&format=json")

class DataManager {
    
    func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let downloadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
            
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"http://realtime.portauthority.org", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                    print("error w/ http request")
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        downloadDataTask.resume()
        
    }
    
    func getDirectionDataFromAPIWithSuccess(success: ((directionsData: NSData!) -> Void)) {
        loadDataFromURL(directionsURL!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(directionsData: urlData)
            }
        })
    }
    
}
