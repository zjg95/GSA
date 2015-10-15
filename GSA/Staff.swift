//
//  Staff.swift
//  GSA
//
//  Created by Zach Goodman on 10/14/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

// staff

class Staff {
    
    // ------------
    // data members
    // ------------
    
    private var employeeList: [Employee] = []
    
    var count: Int {
        get {
            return employeeList.count
        }
    }
    
    subscript(index: Int) -> Employee {
        get {
            return employeeList[index]
        }
        set(newValue) {
            employeeList[index] = newValue
        }
    }
    
    var employeeNames: [String] {
        get {
            var list: [String] = []
            for employee in employeeList {
                list.append(employee.fullName)
            }
            return list
        }
    }
    
    // copy constructor
    
    convenience init(that: Staff) {
        self.init()
        employeeList = that.employeeList
    }
    
    // -------
    // methods
    // -------
    
    func append(employee: Employee) {
        employeeList.append(employee)
    }
    
    func removeAtIndex(index: Int) {
        employeeList.removeAtIndex(index)
    }
    
    func employeeIndex(employee: Employee) -> Int {
        var i: Int = 0
        for e in employeeList {
            if e.fullName == employee.fullName {
                break
            }
            ++i
        }
        return i
    }
    
}