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
    
    private var _timeStart: Int = 0
    private var _timeEnd: Int = 0
    private var _day: Int = 0
    private var _position: String = ""
    
    // ---------
    // accessors
    // ---------
    
    var timeAMPM: String {
        get {
            // Convert Time end and start into a string of AM and/or PM
            var startAMPM = "am"
            var endAMPM = "am"
            var start = _timeStart
            var end = _timeEnd
            if start > 12 {
                start = start - 12
                startAMPM = "pm"
            }
            if  end > 12 {
                end = end - 12
                endAMPM = "pm"
            }
            return " \(start)\(startAMPM) - \(end)\(endAMPM)"
        }
        set (newName) {
            // Convert time String into number time
        }
    }
    
    var timeStart: Int {
        get {
            return _timeStart
        }
        set (newTimeStart) {
            _timeStart = newTimeStart
        }
    }
    
    var timeEnd: Int{
        get {
            return _timeEnd
        }
        set (newTimeEnd) {
            _timeStart = newTimeEnd
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
    
    var duration: Int {
        get {
            return _timeEnd - _timeStart
        }
    }
    
    // -----------
    // constructor
    // -----------
    
    init(timeStart: Int, timeEnd: Int, day: Int) {
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