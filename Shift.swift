//
//  Shift.swift
//  GSA
//
//  Created by Andrew Capindo on 10/12/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation
// --------
// Employee
// --------

class Shift {
    
    // ------------
    // data members
    // ------------
    
    private var _timeStart: Time
    private var _timeEnd: Time
    private var _day: Int = 0
    private var _position: String = ""
//    private var employees: [Employee]
    private var _dayString: String = ""
    
    // ---------
    // accessors
    // ---------
    
    var timeAMPM: String {
        get {
            // Convert Time end and start into a string of AM and/or PM
            var startAMPM = "am"
            var endAMPM = "am"
            var start = _timeStart.hour
            var end = _timeEnd.hour
            if start > 12 {
                start = start - 12
                startAMPM = "pm"
            }
            if  end > 12 {
                end = end - 12
                endAMPM = "pm"
            }
            return " \(start):\(_timeStart.minuteString)\(startAMPM) - \(end):\(_timeEnd.minuteString)\(endAMPM)"
        }
    }
    
    var timeStart: Time {
        get {
            return _timeStart
        }
        set (newTimeStart) {
            _timeStart = newTimeStart
        }
    }
    
    var timeEnd: Time {
        get {
            return _timeEnd
        }
        set (newTimeEnd) {
            _timeEnd = newTimeEnd
        }
    }
    
    var day: Int{
        get {
            return _day
        }
        set (day) {
            _day = day
        }
    }
    
    var duration: String {
        get {
            var hour = _timeEnd.hour - _timeStart.hour
            if (_timeStart.minutes > _timeEnd.minutes){
                hour = hour - 1;
            }
            let minutes = _timeEnd.minutes - _timeStart.minutes
            return "\(hour) hour(s) and \(minutes) minutes"
        }
    }
    
    
    // -----------
    // constructor
    // -----------
    
    init(timeStart: Time, timeEnd: Time, day: Int) {
        _timeStart = timeStart
        _timeEnd = timeEnd
        _day = day
    }
    
//    convenience init(timeStart: Int, timeEnd: Int) {
//        self.init(timeStart: timeStart, timeEnd: timeEnd)
//        _timeStart = timeStart
//        _timeEnd = timeEnd
//    }
    
}