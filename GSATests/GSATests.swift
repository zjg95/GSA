//
//  GSATests.swift
//  GSATests
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import XCTest
@testable import GSA

class GSATests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    // --------------
    // schedule tests
    // --------------
    
    func testSchedule1() {
        let staff: Staff = Staff()
        staff.append(Employee(firstName: "jon"))
        let schedule: Schedule = Schedule(name: "default", staff: staff, week: Week())
        XCTAssert(schedule.numberOfEmployees == 1)
        XCTAssert(schedule.numberOfShifts == 0)
        XCTAssert(schedule.numberOfUnassignedShifts == 0)
    }
    
    func testSchedule2() {
        let staff: Staff = Staff()
        staff.append(Employee(firstName: "jon"))
        XCTAssert(!staff[0].isNullEmployee)
        let schedule: Schedule = Schedule(name: "default", staff: staff, week: Week())
        schedule.append(Shift(timeStart: Time(hour: 0, minutes: 0), timeEnd: Time(hour: 0, minutes: 0), day: 0))
        XCTAssert(schedule.numberOfEmployees == 1)
        XCTAssert(schedule.numberOfShifts == 1)
        XCTAssert(schedule.numberOfUnassignedShifts == 1)
    }
    
    func testSchedule3() {
        let staff: Staff = Staff()
        staff.append(Employee(firstName: "jon"))
        
        XCTAssert(!staff[0].isNullEmployee)
        
        let schedule: Schedule = Schedule(name: "default", staff: staff, week: Week())
        let shift: Shift = Shift(timeStart: Time(hour: 0, minutes: 0), timeEnd: Time(hour: 0, minutes: 0), day: 0)
        schedule.append(shift)
        
        shift.assignee = staff[0]
        
        XCTAssert(schedule.numberOfEmployees == 1)
        XCTAssert(schedule.numberOfShifts == 1)
        XCTAssert(schedule.numberOfUnassignedShifts == 0)
        XCTAssert(staff[0].shiftCount == 1)
    }
    
    func testSchedule4() {
        let staff: Staff = Staff()
        staff.append(Employee(firstName: "jon"))
        
        XCTAssert(!staff[0].isNullEmployee)
        
        let schedule: Schedule = Schedule(name: "default", staff: staff, week: Week())
        let shift: Shift = Shift(timeStart: Time(hour: 0, minutes: 0), timeEnd: Time(hour: 0, minutes: 0), day: 0)
        schedule.append(shift)
        
        shift.assignee = staff[0]
        
        shift.assignee = nil
        
        XCTAssert(schedule.numberOfEmployees == 1)
        XCTAssert(schedule.numberOfShifts == 1)
        XCTAssert(schedule.numberOfUnassignedShifts == 0)
        XCTAssert(staff[0].shiftCount == 0)
    }
    
    func testSchedule5() {
        let staff: Staff = Staff()
        staff.append(Employee(firstName: "jon"))
        
        XCTAssert(!staff[0].isNullEmployee)
        
        let schedule: Schedule = Schedule(name: "default", staff: staff, week: Week())
        let shift: Shift = Shift(timeStart: Time(hour: 0, minutes: 0), timeEnd: Time(hour: 0, minutes: 0), day: 0)
        schedule.append(shift)
        
        shift.assignee = staff[0]
        
        shift.assignee = schedule.nullEmployee
        
        XCTAssert(schedule.numberOfEmployees == 1)
        XCTAssert(schedule.numberOfShifts == 1)
        XCTAssert(schedule.numberOfUnassignedShifts == 1)
        XCTAssert(staff[0].shiftCount == 0)
    }
    
    func testSchedule6() {
        let staff: Staff = Staff()
        staff.append(Employee(firstName: "jon"))
        
        XCTAssert(!staff[0].isNullEmployee)
        
        let schedule: Schedule = Schedule(name: "default", staff: staff, week: Week())
        let shift: Shift = Shift(timeStart: Time(hour: 0, minutes: 0), timeEnd: Time(hour: 0, minutes: 0), day: 0)
        schedule.append(shift)
        
        shift.assignee = staff[0]
        
        schedule.remove(shift)
        
        XCTAssert(schedule.numberOfEmployees == 1)
        XCTAssert(schedule.numberOfShifts == 0)
        XCTAssert(schedule.numberOfUnassignedShifts == 0)
        XCTAssert(staff[0].shiftCount == 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
