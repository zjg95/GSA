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
    
    var numberOfEmployees: Int {
        get {
            return staff.count
        }
    }
    
    var unassignedShiftCount: Int {
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
            shift.assignee = nullEmployee
        }
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
    
    // does not change assignee data
    func reinsert(shift: Shift) {
        
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
        return week[index.section][index.row]
    }
}