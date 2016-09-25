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
    
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var arrivalField: UITextField!
    @IBOutlet weak var alertField: UITextField!
    
    var timer = busTimer()

    @IBAction func startTimer() {
        busTimer.startTimer()
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

