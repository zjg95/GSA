//
//  Employee.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

// --------
// Employee
// --------

private let wiggleRoom: Int = 3

class Employee : CopyProtocol, Equatable, CustomStringConvertible {
    
    // ------------
    // data members
    // ------------
    
    var firstName: String = ""
    var lastName: String = ""
    var position: String = ""
    var index: Int!
    
    var maxHours: Int = 40
    var desiredHours: Int = 40
    var minimumHours: Int = 0
    
    private var _null: Bool = false
    
    
    // We be used for position array
//    var positions: [Position] = []
    
    var shifts: Week = Week()
    var availability: Week = Week()
    
    var description: String {
        get {
            return fullName
        }
    }
    
    var isNullEmployee: Bool {
        get {
            return self._null
        }
    }
    
    var shiftCount: Int {
        get {
            return shifts.shiftCount
        }
    }
    
    var fullName: String {
        get {
            if firstName != "" && lastName != "" {
                return firstName + " " + lastName
            }
            if firstName != "" {
                return firstName
            }
            return lastName
        }
    }
    
    // ------------
    // constructors
    // ------------
    
    init(firstName: String) {
        self.firstName = firstName
    }
    
    convenience init(null: Bool) {
        self.init(firstName: "Unassigned")
        self._null = null
    }
    
    convenience init(firstName: String, lastName: String) {
        self.init(firstName: firstName)
        self.lastName = lastName
    }
    
    convenience init(firstName: String, lastName: String, position: String) {
        self.init(firstName: firstName, lastName: lastName)
        self.position = position
    }
    
    // required initializer for the Copying protocol
    required init(original: Employee) {
        firstName = original.firstName
        lastName = original.lastName
        position = original.position
        index = original.index
        availability = original.availability
    }
    
    // -------
    // methods
    // -------
    
    func indexOfShift(shift: Shift) -> Int? {
        var i = 0
        for s in shifts {
            if shift == s {
                return i
            }
            ++i
        }
        return nil
    }
    
    func shiftNumberByDay(shift: Shift) -> Int {
        return shifts.shiftNumberByDay(shift)
    }
    
    func shiftNumberByWeek(shift: Shift) -> Int {
        return shifts.shiftNumberByWeek(shift)
    }
    
    func getShiftAtIndex(index: Int) -> Shift? {
        return shifts[index]
    }
    
    func append(shift: Shift) {
        shifts.append(shift)
    }
    
    func remove(shift: Shift) {
        shifts.remove(shift)
    }
    
    // ------------------
    // scheduling methods
    // ------------------
    
    // if the shift's position a position that the employee is qualified to work
    private func canWorkPosition(shift: Shift) -> Bool {
        return true
    }
    
    // if working the shift would cause the employee to exceed their desired hours by more than the wiggle room
    private func exceedsDesiredHours(shift: Shift) -> Bool {
        return false
    }
    
    // if working the shift would cause the employee to exceed their max hours
    private func exceedsMaxHours(shift: Shift) -> Bool {
        return false
    }
    
    // if the employee is actually available during that time
    private func isAvailableForShift(shift: Shift) -> Bool {
        let unavailable: [Shift] = availability[shift.day]
        if unavailable.isEmpty{
            return true
        }
        for uaTime in unavailable {
            if uaTime.timeStart.compareTo(shift.timeStart) == 1 && uaTime.timeStart.compareTo(shift.timeEnd) == 1 {
                return true
            }
            if uaTime.timeEnd.compareTo(shift.timeStart) == -1 && uaTime.timeStart.compareTo(shift.timeEnd) == -1 {
                return true
            }
        }
        return false
    }
    
    // if overall the employee is able to work the shift
    func canWorkShift(shift: Shift) -> Bool {
        return isAvailableForShift(shift)
    }
    
    func appendAvail(shift: Shift){
        availability.append(shift)
    }
    
    //Doesn't work for over night shifts
    func isAvailable(shift: Shift) -> Bool {
        let day = shift.day
        let start = shift.timeStart.hour
        let end = shift.timeEnd.hour
        
        let available: [Shift] = availability[day]
        
        for curShift in available {
            if start >= curShift.timeStart.hour && end <= curShift.timeEnd.hour{
                if shift.timeStart.minutes >= curShift.timeStart.minutes && shift.timeEnd.minutes <= curShift.timeEnd.minutes {
                    return true
                }
            }
        }
        return false
    }
}

func ==(lhs: Employee, rhs: Employee) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}