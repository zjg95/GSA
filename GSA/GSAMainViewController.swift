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
        
        staff.append(Employee(firstName: "Gus", lastName: "Ortiz", position: "Manager"))
        staff.append(Employee(firstName: "Juan", lastName: "Rivas", position: "Shift Leader"))
        staff.append(Employee(firstName: "Troy", lastName: "Rowden", position: "Shift Leader"))
        staff.append(Employee(firstName: "John", lastName: "Larkin", position: "Employee"))
        
        let schedule: Schedule = Schedule(name: "Demo Schedule", staff: staff.copy(), week: week.copy())
        
        schedule.append(Shift(timeStart: Time(hour: 9, minutes: 0), timeEnd: Time(hour: 10, minutes: 0), day: 0))
        schedule.append(Shift(timeStart: Time(hour: 12, minutes: 0), timeEnd: Time(hour: 13, minutes: 0), day: 1))
        schedule.append(Shift(timeStart: Time(hour: 10, minutes: 0), timeEnd: Time(hour: 17, minutes: 0), day: 2))
        schedule.append(Shift(timeStart: Time(hour: 6, minutes: 0), timeEnd: Time(hour: 10, minutes: 0), day: 3))
        schedule.append(Shift(timeStart: Time(hour: 11, minutes: 0), timeEnd: Time(hour: 17, minutes: 0), day: 4))
        schedule.append(Shift(timeStart: Time(hour: 14, minutes: 0), timeEnd: Time(hour: 16, minutes: 0), day: 5))
        schedule.append(Shift(timeStart: Time(hour: 13, minutes: 0), timeEnd: Time(hour: 20, minutes: 0), day: 6))
        
        scheduleList = [schedule]
        
        if let nav = self.viewControllers![0] as? UINavigationController {
            if let schedule = nav.viewControllers.first as? ScheduleListTableViewController {
                schedule.scheduleList = self.scheduleList
                schedule.staff = self.staff
                nav.navigationBar.barTintColor = UIColor.blueColor()
            }
        }
        if let nav = self.viewControllers![1] as? UINavigationController {
            if let employee = nav.viewControllers.first as? EmployeeTableViewController {
                employee.staff = self.staff
            }
        }
//        if let nav = self.viewControllers![2] as? UINavigationController {
//        
//        }
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
