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
    
    var employeeView: Bool = true
    
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
        if employeeView == true {
            return schedule.staff.count + 1
        }
        else {
            return days.count
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if employeeView == true {
            if section == schedule.staff.count {
                return 0
            }
            return schedule.staff[section].shiftCount
        }
        else {
            return schedule.week[section].count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
        var title: String!
        var detail: String!
        if employeeView == true {
            if indexPath.section == schedule.staff.count {
                // unassigned shift
                title = "TBA"
                detail = "TBA"
            }
            else {
                let emp: Employee = schedule.staff[indexPath.section]
                let shift: Shift = emp[indexPath.row]!
                title = days[shift.day]
                detail = shift.timeAMPM
            }
        }
        else {
            let shift: Shift = schedule.week[indexPath.section][indexPath.row]
            detail = String(shift.timeAMPM)
            if let employee = shift.assignee {
                title = employee.fullName
            } else {
                title = "Unassigned"
            }
        }
        cell.textLabel!.text = title
        cell.detailTextLabel!.text = detail
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if employeeView == true {
            if section == schedule.staff.count {
                return "Unassigned"
            }
            return schedule.staff[section].fullName
        }
        else {
            return days[section]
        }
    }
    
    func editCell(shift: Shift, index: NSIndexPath) {
        // time data
        let day = shift.day
        var cell: UITableViewCell?
        if day != index.section {
            // shift was moved to another day
            deleteShift(index)
            let newIndexPath = NSIndexPath(forRow: schedule.week[shift.day].count, inSection: shift.day)
            addShift(shift)
            cell = tableView.cellForRowAtIndexPath(newIndexPath)
        }
        else {
            // shift time has changed
            cell = tableView.cellForRowAtIndexPath(index)
            cell?.textLabel?.text = shift.timeAMPM
            cell?.detailTextLabel?.text = shift.duration
        }
        
        // assignee data
        if let employee = shift.assignee {
            cell?.detailTextLabel?.text = employee.fullName
        }
        else {
            cell?.detailTextLabel?.text = "Unassigned"
        }
    }
    
    // adapted from ShiftTableViewController.swift
    
    func addShift(shift: Shift) {
        // add shift to data array
        // add shift to table
        let newIndexPath = NSIndexPath(forRow: schedule.week[shift.day].count, inSection: shift.day)
        schedule.week.append(shift)
        if employeeView == true {
            
        }
        else {
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    
    // adapted from ShiftTableViewController.swift
    
    func deleteShift(index: NSIndexPath) {
        // delete shift from data array
        // delete shift from table
        if employeeView == true {
            
        }
        else {
            schedule.week[index.section].removeAtIndex(index.row)
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Bottom)
            if tableView.numberOfRowsInSection(index.section) == 0 {
                // delete empty section, the following line causes a crash
                //tableView.deleteSections(NSIndexSet(index: index.section), withRowAnimation: .Bottom)
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "scheduleDetailsSegue") {
            if let destination = segue.destinationViewController as? ScheduleDetailsViewController {
                let index = self.tableView!.indexPathForSelectedRow
                destination.delegate = self
                destination.index = index
                destination.shift = schedule.week[index!.section][index!.row]
                destination.staff = schedule.staff
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
