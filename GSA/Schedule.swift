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
    }
    
    convenience init(name: String) {
        self.init(name: name, staff: Staff(), week: Week())
        clearAssignees()
    }
    
    // -------
    // methods
    // -------
    
    func clearAssignees() {
        for shift in week {
            shift.assignee = nullEmployee
        }
    }
    
    func shiftsOnDay(day: Int) -> Int {
        return week.shiftCount(day)
    }
    
    func shiftsForEmployee(employee: Int) -> Int {
        return staff.numberOfShiftsAssignedToEmployee(employee)
    }
    
    func numberOfShiftsOnDay(day: Int) -> Int {
        return week.shiftCount(day)
    }
    
    func getEmployeeAtIndex(index: Int) -> Employee {
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
    
    func getShiftAtIndex(index: NSIndexPath) -> Shift {
        return week[index.section][index.row]
    }
}