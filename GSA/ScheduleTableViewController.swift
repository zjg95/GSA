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
            return schedule.numberOfShiftsOnDay(section)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
        if employeeView {
            buildCellEmployeeView(cell, index: indexPath)
        }
        else {
            buildCellShiftView(cell, index: indexPath)
        }
        return cell
    }
    
    func buildCellShiftView(cell: UITableViewCell, index: NSIndexPath) {
        let shift: Shift = schedule.getShiftAtIndex(index)
        cell.textLabel!.text = shift.assignee!.fullName
        cell.detailTextLabel!.text = shift.timeAMPM
    }
    
    func buildCellEmployeeView(cell: UITableViewCell, index: NSIndexPath) {
        let emp: Employee = schedule.getEmployeeAtIndex(index.section)
        let shift: Shift! = emp.getShiftAtIndex(index.row)
        cell.textLabel!.text = days[shift.day]
        cell.detailTextLabel!.text = shift.timeAMPM
    }
    
    // ------------
    // section name
    // ------------
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if employeeView {
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
    
    func editShift(oldShift: Shift, newShift: Shift, oldIndex: NSIndexPath) {
        var newIndex: NSIndexPath!
        if employeeView {
            newIndex = editShiftEmployeeView(oldShift, newShift: newShift, oldIndex: oldIndex)
        }
        else {
            newIndex = editShiftShiftView(oldShift, newShift: newShift, oldIndex: oldIndex)
        }
        assert(newIndex != nil)
        assert(delegate != nil)
        // update the shift in the details view
        delegate.index = newIndex
        delegate.shift = newShift
    }
    
    func editShiftEmployeeView(oldShift: Shift, newShift: Shift, oldIndex: NSIndexPath) -> NSIndexPath {
        let emp: Employee! = newShift.assignee
        newShift.assignee = nil
        // remove the old shift
        removeShift(oldIndex)
        // add the new shift
        newShift.assignee = emp
        return addShift(newShift)
    }
    
    func editShiftShiftView(oldShift: Shift, newShift: Shift, oldIndex: NSIndexPath) -> NSIndexPath {
        // remove the old shift
        removeShift(oldIndex)
        // add the new shift
        return addShift(newShift)
    }
    
    // ---------
    // add shift
    // ---------
    
    // adds a shift to the schedule and creates a cell
    func addShift(shift: Shift) -> NSIndexPath {
        var index: NSIndexPath!
        if employeeView {
            index = addShiftEmployeeView(shift)
        }
        else {
            index = schedule.append(shift)
        }
        addCell(index)
        return index
    }
    
    // adds a shift to the schedule
    func addShiftEmployeeView(shift: Shift) -> NSIndexPath {
        schedule.append(shift)
        let employee: Employee! = shift.assignee
        assert(employee != nil)
        let employeeIndex: NSIndexPath = NSIndexPath(forRow: employee.indexOfShift(shift), inSection: employee.index)
        return employeeIndex
    }
    
    // create a cell at given index
    func addCell(index: NSIndexPath) {
        tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Fade)
    }
    
    // ------------
    // remove shift
    // ------------
    
    // remove shift from schedule, delete its cell
    func removeShift(index: NSIndexPath) {
        if employeeView {
            print("employee index: \(index.section) shift index: \(index.row)")
            let emp: Employee = schedule.getEmployeeAtIndex(index.section)
            print("employee: \(emp.fullName)")
            for s in emp.shifts {
                print("\(days[s.day]) \(s.timeAMPM)")
            }
            let shift: Shift! = emp.getShiftAtIndex(index.row)
            assert(shift != nil)
            print("shift: \(days[shift.day]) \(shift.timeAMPM)")
            let shiftIndex: NSIndexPath! = schedule.indexOfShift(shift)
            assert(shiftIndex != nil)
            schedule.removeShiftAtIndex(shiftIndex)
        }
        else {
            schedule.removeShiftAtIndex(index)
        }
        removeCell(index)
    }
    
    // remove cell from table
    func removeCell(index: NSIndexPath) {
        tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Fade)
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
