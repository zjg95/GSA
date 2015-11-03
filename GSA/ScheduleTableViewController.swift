//
//  ScheduleTableViewController.swift
//  GSA
//
//  Created by David Acker on 10/14/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation
import UIKit

class ScheduleTableViewController: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    var schedule: Schedule!
    
    var delegate: ScheduleDetailsViewController!
    
    var employeeView: Bool = false
    
    // -------
    // outlets
    // -------
    
    @IBAction func organizeButton(sender: AnyObject) {
        employeeView = !employeeView
        self.tableView.reloadData()
    }
    
    // -------
    // methods
    // -------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = schedule.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if employeeView {
            return schedule.numberOfEmployees + 1
        }
        else {
            return 7 // 7 days in a week
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if employeeView {
            if section == schedule.numberOfEmployees {
                return schedule.unassignedShiftCount
            }
            let employee: Employee = schedule.getEmployeeAtIndex(section)
            return employee.shiftCount
        }
        else {
            return schedule.shiftsOnDay(section)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
        if employeeView {
            buildCellShiftView(cell, index: indexPath)
        }
        else {
            buildCellEmployeeView(cell, index: indexPath)
        }
        return cell
    }
    
    func buildCellShiftView(cell: UITableViewCell, index: NSIndexPath) {
        
    }
    
    func buildCellEmployeeView(cell: UITableViewCell, index: NSIndexPath) {
        
    }
    
    // ------------
    // section name
    // ------------
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if employeeView {
            if section == schedule.numberOfEmployees {
                // null employee, shift not assigned
                return "Unassigned"
            }
            // assignee name
            return schedule.getEmployeeAtIndex(section).fullName
        }
        else {
            // day name
            return days[section]
        }
    }
    
    // ---------
    // edit cell
    // ---------
    
    func editCell(shift: Shift, index: NSIndexPath) {
        if employeeView {
            editCellEmployeeView(shift, index: index)
        }
        else {
            editCellShiftView(shift, index: index)
        }
    }
    
    func editCellEmployeeView(shift: Shift, index: NSIndexPath) {
        // was day modified?
        // was assignee modified?
        // was start/end time modified?
        // was shift deleted?
    }
    
    func editCellShiftView(shift: Shift, index: NSIndexPath) {
        // was day modified?
        // was assignee modified?
        // was start/end time modified?
        // was shift deleted?
    }
    
    // ---------
    // add shift
    // ---------
    
    func addShift(shift: Shift) {
        // add shift to data array
        // add shift to table
    }
    
    // ------------
    // remove shift
    // ------------
    
    func removeShift(index: NSIndexPath) {
        // delete shift from data array
        // delete shift from table
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "scheduleDetailsSegue") {
            if let destination = segue.destinationViewController as? ScheduleDetailsViewController {
                
                let index: NSIndexPath! = self.tableView!.indexPathForSelectedRow
                var shift: Shift!
                delegate = destination
                destination.delegate = self
                destination.staff = schedule.staff
                destination.index = index
                
                if employeeView {
                    if index.section == schedule.staff.count {
                        // null employee
                        shift = schedule.nullEmployee.getShiftAtIndex(index.row)
                    }
                    else {
                        shift = schedule.getEmployeeAtIndex(index.section).getShiftAtIndex(index.row)
                    }
                }
                else {
                    shift = schedule.week[index.section][index.row]
                }
                
                destination.shift = shift
            }
        }
    }
    
    @IBAction func addShiftToTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewShiftViewController, shift = sourceViewController.shift {
            addShift(shift)
        }
    }
    
    @IBAction func deleteShiftFromTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditScheduleViewController, index = sourceViewController.index {
            removeShift(index)
        }
    }
    
}
