//
//  Staff.swift
//  GSA
//
//  Created by Zach Goodman on 10/14/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

// staff

class Staff : CopyProtocol, SequenceType {
    
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
    
    // -----------
    // constructor
    // -----------
    
    init() {
        
    }
    
    // required initializer for the Copying protocol
    required init(original: Staff) {
        for emp in original.employeeList {
            employeeList.append(emp.copy())
        }
    }
    
    // -------
    // methods
    // -------
    
    func generate() -> AnyGenerator<Employee> {
        // keep the index of the next car in the iteration
        var nextIndex = 0
        
        // Construct a AnyGenerator<Car> instance, passing a closure that returns the next car in the iteration
        return anyGenerator {
            if (nextIndex >= self.count) {
                return nil
            }
            return self[nextIndex++]
        }
    }
    
    func numberOfShiftsAssignedToEmployee(employee: Int) -> Int {
        return employeeList[employee].shiftCount
    }
    
    func append(employee: Employee) {
        employee.index = count
        employeeList.append(employee)
    }
    
    func indexEmployees() {
        var c: Int = 0
        for employee in employeeList {
            employee.index = c++
        }
    }
    
    func removeAtIndex(index: Int) {
        employeeList.removeAtIndex(index)
        indexEmployees()
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