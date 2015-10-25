//
//  GSAMainViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/22/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class GSAMainViewController: UITabBarController {
    
    // ------------
    // data members
    // ------------
    
    let staff: Staff = Staff()
    let week: Week = Week()
    var scheduleList: [Schedule]!
    
    // -------
    // methods
    // -------

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scheduleList = [Schedule(name: "Week 1", staff: staff, week: week)]
        
        let shift1: Shift = Shift(timeStart: Time(hour: 18, minutes: 0), timeEnd: Time(hour: 19, minutes: 30), day: 4)
        let shift2: Shift = Shift(timeStart: Time(hour: 18, minutes: 0), timeEnd: Time(hour: 19, minutes: 30), day: 2)
        let employee: Employee = Employee(firstName: "Robert", lastName: "Seitsinger")
        employee.position = "Professor"
        shift1._employee = employee
        shift2._employee = employee
        week[4].append(shift1)
        week[2].append(shift2)
        staff.append(employee)
        
        if let nav = self.viewControllers![0] as? UINavigationController {
            if let schedule = nav.viewControllers.first as? ScheduleListTableViewController {
                schedule.scheduleList = self.scheduleList
            }
        }
        if let nav = self.viewControllers![1] as? UINavigationController {
            if let employee = nav.viewControllers.first as? EmployeeTableViewController {
                employee.staff = self.staff
            }
        }
        if let nav = self.viewControllers![2] as? UINavigationController {
            if let shift = nav.viewControllers.first as? ShiftTableViewController {
                shift.week = self.week
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
