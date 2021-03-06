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
    
    subscript(var index: Int) -> Shift? {
        get {
            if index <= count {
                for day in shifts {
                    if index >= day.count {
                        index -= day.count
                    }
                    else {
                        return day[index]
                    }
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
        var nextIndex = 0
        
        // Construct a AnyGenerator<Car> instance, passing a closure that returns the next car in the iteration
        return anyGenerator {
            if (nextIndex >= self.count) {
                return nil
            }
            return self[nextIndex++]
        }
    }
    
    func indexOfShift(shift: Shift) -> NSIndexPath? {
        for var day: Int = 0; day < 7; ++day {
            for var num: Int = 0; num < shifts[day].count; ++num {
                if shifts[day][num] == shift {
                    return NSIndexPath(forRow: num, inSection: day)
                }
            }
        }
        return nil
    }
    
    func numberOfShiftsOnDay(day: Int) -> Int {
        return shifts[day].count
    }
    
    func append(shift: Shift) -> NSIndexPath {
        var i: Int = 0
        for s in shifts[shift.day] {
            if shift.compareTo(s) < 0 {
                break
            }
            ++i
        }
        shifts[shift.day].insert(shift, atIndex: i)
        ++count
        return NSIndexPath(forItem: i, inSection: shift.day)
    }
    
    func removeAtIndex(index: NSIndexPath) {
        shifts[index.section].removeAtIndex(index.row)
        --count
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
    
    func shiftNumberByWeek(shift: Shift) -> Int {
        var i = 0
        for s in self {
            if shift == s {
                break
            }
            ++i
        }
        return i
    }
    
    func shiftNumberByDay(shift: Shift) -> Int {
        var i = 0
        for s in shifts[shift.day] {
            if shift == s {
                break
            }
            ++i
        }
        return i
    }
    
    func weekToArray() -> [Shift] {
        var i:Int = 0
        var j:Int = 0
        var newShifts = [Shift]();
        for i = 0; i < shifts.count; i++ {
            for j = 0; j < shifts[i].count; j++ {
                newShifts.append(shifts[i][j])
            }
        }
        return newShifts
    }
    
}