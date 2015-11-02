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
        // #warning Incomplete implementation, return the number of sections
        if employeeView {
            return schedule.numberOfEmployees + 1
        }
        else {
            return 7 // 7 days in a week
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if employeeView {
            if section == schedule.numberOfEmployees {
                return schedule.unassignedShiftCount
            }
            return schedule.shiftsAssignedToEmployeeAtIndex(section)
        }
        else {
            return schedule.shiftsOnDay(section)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
        var title: String!
        var detail: String!
        if employeeView {
            var emp: Employee!
            if indexPath.section == schedule.numberOfEmployees {
                // unassigned shift
                emp = schedule.nullEmployee
            }
            else {
                emp = schedule.getEmployeeAtIndex(indexPath.section)
            }
            let shift: Shift = emp.getShiftAtIndex(indexPath.row)
            title = days[shift.day]
            detail = shift.timeAMPM
        }
        else {
            let shift: Shift = schedule.getShiftAtIndex(indexPath)
            detail = String(shift.timeAMPM)
            if shift.assignee!.isNullEmployee == false {
                title = shift.assignee!.fullName
            } else {
                title = "Unassigned"
            }
        }
        cell.textLabel!.text = title
        cell.detailTextLabel!.text = detail
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if employeeView {
            if section == schedule.numberOfEmployees {
                return "Unassigned"
            }
            return schedule.getEmployeeAtIndex(section).fullName
        }
        else {
            return days[section]
        }
    }
    
    func editCell(shift: Shift, index: NSIndexPath) {
        if employeeView {
            editCellEmployeeView(shift, index: index)
        }
        else {
            editCellShiftView(shift, index: index)
        }
    }
    
    func editCellEmployeeView(shift: Shift, index: NSIndexPath) {
        print(index)
        // was day modified?
        // was assignee modified?
        // was start/end time modified?
        // was shift deleted?
    }
    
    func editCellShiftView(shift: Shift, index: NSIndexPath) {
        // time data
        let day = shift.day
        var cell: UITableViewCell?
        if day != index.section {
            // shift was moved to another day
            deleteShift(index)
            let newIndexPath = NSIndexPath(forRow: schedule.numberOfShiftsOnDay(shift.day), inSection: shift.day)
            addShift(shift)
            delegate.index = newIndexPath
            cell = tableView.cellForRowAtIndexPath(newIndexPath)
        }
        else {
            // shift time has changed
            cell = tableView.cellForRowAtIndexPath(index)
            cell?.detailTextLabel!.text = shift.timeAMPM
        }
        
        // assignee data
        if let employee = shift.assignee {
            cell?.textLabel!.text = employee.fullName
        }
        else {
            shift.assignee = schedule.nullEmployee
            cell?.textLabel!.text = "Unassigned"
        }
    }
    
    // adapted from ShiftTableViewController.swift
    
    func addShift(shift: Shift) {
        // add shift to data array
        // add shift to table
        var newIndexPath: NSIndexPath!
        if employeeView {
            // get index path
            newIndexPath = NSIndexPath(forRow: schedule.nullEmployee.shiftCount, inSection: schedule.numberOfEmployees)
            schedule.append(shift)
            let empIndex: Int = shift.assigneeIndex!
            print(shift.assignee!)
            print(empIndex)
            print(newIndexPath)
        }
        else {
            newIndexPath = schedule.append(shift)
        }
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
    }
    
    // adapted from ShiftTableViewController.swift
    
    func deleteShift(index: NSIndexPath) {
        // delete shift from data array
        // delete shift from table
        if employeeView {
            // get index path
        }
        else {
            schedule.removeShiftAtIndex(index)
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Bottom)
        }
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
            deleteShift(index)
        }
    }
    
}
