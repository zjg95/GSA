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
                return schedule.nullEmployee.shiftCount
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
            var emp: Employee!
            if indexPath.section == schedule.staff.count {
                // unassigned shift
                emp = schedule.nullEmployee
            }
            else {
                emp = schedule.staff[indexPath.section]
            }
            let shift: Shift = emp[indexPath.row]!
            title = days[shift.day]
            detail = shift.timeAMPM
        }
        else {
            let shift: Shift = schedule.week[indexPath.section][indexPath.row]
            detail = String(shift.timeAMPM)
            if shift.assignee!.null == false {
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
        if employeeView == true {
            newIndexPath = NSIndexPath(forRow: schedule.nullEmployee.shiftCount, inSection: schedule.staff.count)
        }
        else {
            newIndexPath = NSIndexPath(forRow: schedule.week[shift.day].count, inSection: shift.day)
        }
        schedule.append(shift)
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
    }
    
    // adapted from ShiftTableViewController.swift
    
    func deleteShift(index: NSIndexPath) {
        // delete shift from data array
        // delete shift from table
        if employeeView == true {
            let shift: Shift = schedule.staff[index.section][index.row]!
            let newIndex: NSIndexPath = schedule.remove(shift)
            print(newIndex)
            tableView.deleteRowsAtIndexPaths([newIndex], withRowAnimation: .Bottom)
        }
        else {
            schedule.remove(schedule.shift(index))
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
                
                let index: NSIndexPath! = self.tableView!.indexPathForSelectedRow
                var shift: Shift!
                delegate = destination
                destination.delegate = self
                destination.staff = schedule.staff
                destination.index = index
                
                if employeeView == true {
                    if index.section == schedule.staff.count {
                        // null employee
                        shift = schedule.nullEmployee[index.row]
                    }
                    else {
                        shift = schedule.staff[index.section][index.row]
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
