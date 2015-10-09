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
    
    // -----------
    // constructor
    // -----------
    
    init (firstName: String) {
        self.firstName = firstName
    }
    
    convenience init (firstName: String, lastName: String) {
        self.init(firstName: firstName)
        self.lastName = lastName
    }
    
}