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
    
    // constructor
    
    init() {
        
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
    
}