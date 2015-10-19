//
//  ViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var staff: Staff = Staff()
    var week: Week = Week()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // add default data
        let shift1: Shift = Shift(timeStart: Time(hour: 18, minutes: 0), timeEnd: Time(hour: 19, minutes: 30), day: 4)
        let shift2: Shift = Shift(timeStart: Time(hour: 18, minutes: 0), timeEnd: Time(hour: 19, minutes: 30), day: 2)
        let employee: Employee = Employee(firstName: "Robert", lastName: "Seitsinger")
        employee.position = "Professor"
        shift1._employee = employee
        shift2._employee = employee
        week[4].append(shift1)
        week[2].append(shift2)
        staff.append(employee)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "employeeSegue") {
            if let destination = segue.destinationViewController as? EmployeeTableViewController {
                destination.staff = self.staff
            }
        }
        if (segue.identifier == "shiftSegue") {
            if let destination = segue.destinationViewController as? ShiftTableViewController {
                destination.week = self.week
            }
        }
        if (segue.identifier == "scheduleSegue") {
            if let destination = segue.destinationViewController as? ScheduleTableViewController {
                destination.staff = self.staff
                destination.week = self.week
            }
        }
    }

}

