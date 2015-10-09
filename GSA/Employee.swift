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
    
    private var _firstName: String = ""
    private var _lastName: String = ""
    
    // ---------
    // accessors
    // ---------
    
    var firstName: String {
        get {
            return _firstName
        }
        set (newName) {
            _firstName = newName
        }
    }
    
    var lastName: String {
        get {
            return _lastName
        }
        set (newName) {
            _lastName = newName
        }
    }
    
    var fullName: String {
        get {
            return _firstName + " " + _lastName
        }
    }
    
    // -----------
    // constructor
    // -----------
    
    init(firstName: String) {
        _firstName = firstName
    }
    
    convenience init(firstName: String, lastName: String) {
        self.init(firstName: firstName)
        _lastName = lastName
    }
    
}