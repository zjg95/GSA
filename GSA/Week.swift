//
//  Week.swift
//  GSA
//
//  Created by Zach Goodman on 10/14/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

// ----
// week
// ----

class Week {
    
    // ------------
    // data members
    // ------------
    
    private var shifts: [[Shift]] = [[Shift]](count: 7, repeatedValue: [])
    
    var count: Int {
        get {
            var count: Int = 0
            for s in shifts {
                count += s.count
            }
            return count
        }
    }
    
    subscript(index: Int) -> [Shift] {
        get {
            return shifts[index]
        }
        set(newValue) {
            shifts[index] = newValue
        }
    }
    
    // copy constructor
    
    convenience init(that: Week) {
        self.init()
        shifts = that.shifts
    }
    
    // -------
    // methods
    // -------
    
    func append(shift: Shift) {
        shifts[shift.day].append(shift)
    }
    
}