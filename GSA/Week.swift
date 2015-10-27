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

class Week : CopyProtocol {
    
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
    
    // returns the nth shift of the week, nil if it doesn't exist
    
    subscript(index: Int) -> Shift? {
        get {
            var count: Int = index
            for day in shifts {
                if count >= day.count {
                    count -= day.count
                }
                else {
                    return day[count]
                }
            }
            return nil
        }
    }
    
    // -----------
    // constructor
    // -----------
    
    init() {
        
    }
    
    // required initializer for the Copying protocol
    required init(original: Week) {
        for day in original.shifts {
            for shift in day {
                append(shift.copy())
            }
        }
    }
    
    // -------
    // methods
    // -------
    
    func append(shift: Shift) {
        shifts[shift.day].append(shift)
    }
    
}