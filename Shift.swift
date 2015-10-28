//
//  Shift.swift
//  GSA
//
//  Created by Andrew Capindo on 10/12/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

// -----
// Shift
// -----

class Shift : CopyProtocol, Equatable {
    
    // ------------
    // data members
    // ------------
    
    private var _timeStart: Time
    private var _timeEnd: Time
    private var _day: Int = 0
    private var _position: String = ""
    private var _dayString: String = ""
    
    private var _assignee: Employee?
    
    var assignee: Employee? {
        get {
            return _assignee
        }
        set(newValue) {
            if let e = _assignee {
                // notify old employee
                e.remove(self)
            }
            _assignee = newValue
            if let e = _assignee {
                // notify new employee
                e.append(self)
            }
        }
    }
    
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
            var hour = 0
            var minutes = 0
            if (_timeStart.minutes > _timeEnd.minutes){
                var tempStartMin = _timeStart.minutes
                while (tempStartMin != _timeEnd.minutes) {
                    minutes++
                    tempStartMin++
                    if (tempStartMin == 60) {
                        tempStartMin = 0;
                    }
                }
                hour = _timeEnd.hour - _timeStart.hour - 1
            }
            else {
                hour = _timeEnd.hour - _timeStart.hour
                minutes = _timeEnd.minutes - _timeStart.minutes
            }
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
    
    // required initializer for the Copying protocol
    required init(original: Shift) {
        _timeStart = original._timeStart.copy()
        _timeEnd = original._timeEnd.copy()
        _day = original._day
    }
    
    // -------
    // methods
    // -------
    
    func compareTo(otherShift: Shift) -> Int {
        let start: Int = _timeStart.compareTo(otherShift._timeStart)
        if start == 0 {
            return _timeEnd.compareTo(otherShift._timeEnd)
        }
        return start
    }
    
}

func ==(lhs: Shift, rhs: Shift) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}