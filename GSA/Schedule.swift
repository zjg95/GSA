//
//  Schedule.swift
//  GSA
//
//  Created by Zach Goodman on 10/24/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

class Schedule {
    
    // ------------
    // data members
    // ------------
    
    var week: Week!
    var staff: Staff!
    var name: String!
    
    let nullEmployee: Employee = Employee(null: true)
    
    var numberOfShifts: Int {
        get {
            return week.shiftCount
        }
    }
    
    var numberOfEmployees: Int {
        get {
            return staff.count
        }
    }
    
    var numberOfUnassignedShifts: Int {
        get {
            return nullEmployee.shiftCount
        }
    }
    
    // -----------
    // constructor
    // -----------
    
    init(name: String, staff: Staff, week: Week) {
        self.name = name
        self.staff = staff
        self.week = week
        nullEmployee.index = numberOfEmployees
    }
    
    // -------
    // methods
    // -------
    
    func clearAssignees() {
        for shift in week {
            shift.assignee?.currentHoursAsMinutes = 0
            shift.assignee = nullEmployee
        }
    }
    
    func indexOfShift(shift: Shift) -> NSIndexPath? {
        return week.indexOfShift(shift)
    }
    
    func shiftsAssignedToEmployeeAtIndex(index: Int) -> Int {
        return staff.numberOfShiftsAssignedToEmployee(index)
    }
    
    func numberOfShiftsOnDay(day: Int) -> Int {
        return week.numberOfShiftsOnDay(day)
    }
    
    func getEmployeeAtIndex(index: Int) -> Employee {
        if index == nullEmployee.index {
            return nullEmployee
        }
        return staff[index]
    }
    
    func append(shift: Shift) -> NSIndexPath {
        if shift.assignee == nil {
            shift.assignee = nullEmployee
        }
        return week.append(shift)
    }
    
    func remove(shift: Shift) -> NSIndexPath {
        shift.assignee = nil
        return week.remove(shift)
    }
    
    func removeShiftAtIndex(index: NSIndexPath) {
        let shift: Shift = week[index.section][index.row]
        shift.assignee = nil
        week.removeAtIndex(index)
    }
    
    func getShiftAtIndex(index: NSIndexPath) -> Shift {
        assert(index.section < 7)
        assert(index.row < week[index.section].count)
        return week[index.section][index.row]
    }
    
    private func assign(shift: Shift) -> Employee? {
        for employee in staff {
            assert(!employee.isNullEmployee)
            if employee.canWorkShift(shift) {
                let n1 = numberOfUnassignedShifts
                shift.assignee = employee
                let n2 = numberOfUnassignedShifts + 1
                assert(n2 == n1)
                return employee
            }
        }
        return nil
    }
    
    // returns the number of unassigned shifts remaining
    func generate() -> Int {
        // first come first served
        for shift in week {
            assert(shift.assignee != nil)
            assert(shift.assigneeIndex != nil)
            if shift.assignee == nullEmployee {
                // only assign shifts that are unassigned
                assign(shift)
            }
        }
        return numberOfUnassignedShifts
    }
}