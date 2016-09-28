//
//  ViewController.swift
//  RideOn
//
//  Created by Karen on 9/11/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var arrivalField: UILabel!
    @IBOutlet weak var alertField: UILabel!
    
    @IBOutlet weak var alertPicker: UIPickerView!
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var timer = busTimer()

    @IBAction func startTimer() {
        timer.startTimer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // from: http://codewithchris.com/uipickerview-example/
        pickerData = ["5 min before", "10 min before", "15 min before", "30 min before", "1 hr before", "2 hr before", "6 hr before"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func revealPicker() {
        alertPicker.hidden = false
    }
    
    @IBAction func revealDate() {
        datePicker.hidden = false
        submitButton.hidden = true
    }
    
    @IBAction func hideDate() {
        datePicker.hidden = true
        submitButton.hidden = false
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        arrivalField.text = formatter.stringFromDate(datePicker.date)
        arrivalField.hidden = false
    }

    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        alertPicker.hidden = true
        alertField.text = " " + pickerData[row]
        alertField.hidden = false
    }
    
    //  MARK:   UITextView Delegate Functions
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
}

