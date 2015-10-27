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

class Employee : CopyProtocol, Equatable {
    
    // ------------
    // data members
    // ------------
    
    var firstName: String = ""
    var lastName: String = ""
    var position: String = ""
    private var _null: Bool = false
    
    private var shifts: Week = Week()
    
    var null: Bool {
        get {
            return self._null
        }
    }
    
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
    
    convenience init(null: Bool) {
        self.init(firstName: "None")
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
    }
    
    // -------
    // methods
    // -------
    
    func append(shift: Shift) {
        shifts.append(shift)
    }
    
    func remove(shift: Shift) {
        shifts.remove(shift)
    }
    
}

func ==(lhs: Employee, rhs: Employee) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}