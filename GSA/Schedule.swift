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
    
    // -----------
    // constructor
    // -----------
    
    init(name: String, staff: Staff, week: Week) {
        self.name = name
        self.staff = staff
        self.week = week
    }
    
    // -------
    // methods
    // -------
}