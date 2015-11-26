//
//  Persistence.swift
//  GSA
//
//  Created by Zach Goodman on 11/19/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

let defaults = NSUserDefaults.standardUserDefaults()

private let employeeViewString: String = "employeeView"

var employeeView: Bool {
    get {
        if let result: Bool! = defaults.boolForKey(employeeViewString) {
            return result
        }
        return false
    }
    set {
        defaults.setBool(newValue, forKey: employeeViewString)
    }
}