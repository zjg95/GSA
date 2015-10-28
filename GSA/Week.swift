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

class Week : CopyProtocol, SequenceType {
    
    // ------------
    // data members
    // ------------
    
    private var shifts: [[Shift]] = [[Shift]](count: 7, repeatedValue: [])
    private var count: Int = 0
    
    var shiftCount: Int {
        get {
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
    
    func generate() -> AnyGenerator<Shift> {
        // keep the index of the next car in the iteration
        var nextIndex = count - 1
        
        // Construct a AnyGenerator<Car> instance, passing a closure that returns the next car in the iteration
        return anyGenerator {
            if (nextIndex < 0) {
                return nil
            }
            return self[nextIndex--]
        }
    }
    
    func shiftCount(day: Int) -> Int {
        return shifts[day].count
    }
    
    func append(shift: Shift) {
        shifts[shift.day].append(shift)
        ++count
    }
    
    func remove(shift: Shift) -> NSIndexPath {
        var i = 0
        for i = 0; i < shifts[shift.day].count; ++i {
            if shifts[shift.day][i] == shift {
                shifts[shift.day].removeAtIndex(i)
                break
            }
        }
        --count
        return NSIndexPath(forRow: i, inSection: shift.day)
    }
    
}