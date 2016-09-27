//
//  DirectionsViewControllerA.swift
//  RideOn
//
//  Created by Mark Vella on 9/26/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import UIKit

class DirectionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
