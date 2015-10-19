//
//  date.swift
//  GSA
//
//  Created by Andrew Capindo on 10/14/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

class Time {
    private var _hour: Int
    private var _minutes: Int
    
    var hour: Int {
        get {
            return _hour
        }
        set (newHour){
            _hour = newHour
        }
    }
    
    var minutes: Int {
        get {
            return _minutes
        }
        set (newMinutes){
            _minutes = newMinutes
        }
    }
    
    var minuteString: String {
        get {
            var minutes = String(_minutes)
            if (_minutes == 0){
                minutes = "00"
            }
            else if (_minutes < 10){
                minutes = "0\(minutes)"
            }
            return minutes
        }
    }
    
    init(hour: Int, minutes: Int) {
        _hour = hour
        _minutes = minutes
    }    
    
}