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
    
    func append(shift: Shift) {
        if shift.assignee == nil {
            shift.assignee = nullEmployee
        }
        week.append(shift)
    }
    
    func remove(shift: Shift) {
        shift.assignee = nil
        week.remove(shift)
    }
}