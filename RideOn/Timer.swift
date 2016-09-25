//
//  Timer.swift
//  RideOn
//
//  Created by Karen on 9/25/16.
//  Copyright © 2016 Karen. All rights reserved.
//

import Foundation

class busTimer {
    
    var timer = NSTimer()
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self,selector:"countUp", userInfo:nil, repeats:true)
    }
    
    
}
