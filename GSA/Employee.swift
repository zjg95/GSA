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

class Employee {
    
    // ------------
    // data members
    // ------------
    
    var firstName: String = ""
    var lastName: String = ""
    var position: String = ""
    
    private var shifts: Week = Week()
    
    var shiftCount: Int {
        get {
            return shifts.count
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
    
    subscript(index: Int) -> Shift? {
        get {
            return shifts[index]
        }
    }
    
    // ------------
    // constructors
    // ------------
    
    init(firstName: String) {
        self.firstName = firstName
    }
    
    convenience init(firstName: String, lastName: String) {
        self.init(firstName: firstName)
        self.lastName = lastName
    }
    
    convenience init(firstName: String, lastName: String, position: String) {
        self.init(firstName: firstName, lastName: lastName)
        self.position = position
    }
    
    // -------
    // methods
    // -------
    
    func append(shift: Shift) {
        shifts.append(shift)
    }
    
    func remove(shift: Shift) {
        // TODO
    }
    
}