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
    
    var startDay: Int!
    var endDay: Int!
    var day: Int = 0
    
    var position: Position!
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
    
    var assigneeIndex: Int? {
        get {
            if _assignee == nil {
                return nil
            }
            return _assignee!.index
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
            else if start == 12 {
                startAMPM = "pm"
            }
            if  end > 12 {
                end = end - 12
                endAMPM = "pm"
            }
            else if end == 12 {
                endAMPM = "pm"
            }
            if start == 0 {
                start = 12
            }
            if end == 0 {
                end = 12
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
    
    var durationInt: Int {
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
            return hour * 60 + minutes
        }
    }
    
    // -----------
    // constructor
    // -----------
    
    init(timeStart: Time, timeEnd: Time, day: Int) {
        _timeStart = timeStart
        _timeEnd = timeEnd
        self.day = day
    }
    
    // required initializer for the Copying protocol
    required init(original: Shift) {
        _timeStart = original._timeStart.copy()
        _timeEnd = original._timeEnd.copy()
        self.day = original.day
    }
    
    convenience init(startHour: Int, endHour: Int, day: Int) {
        self.init(timeStart: Time(hour: startHour, minutes: 0), timeEnd: Time(hour: endHour, minutes: 0), day: day)
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
    
    func dayToString() -> String {
        switch self.day {
        case 0:
            return "Sunday"
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        default:
            return "invalid day"
        }
    }
    
}

func ==(lhs: Shift, rhs: Shift) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}