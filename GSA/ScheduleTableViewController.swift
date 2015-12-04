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
    
    var delegate: ShiftDetailsTableViewController!
    
    // -------
    // outlets
    // -------
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var generateButton: UIBarButtonItem!
    
    @IBAction func generatePressed(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue()) {
            let alertController = UIAlertController(title: "Confirm Generate", message: "Are you sure you want to automatically assign employees to shifts?", preferredStyle: UIAlertControllerStyle.Alert)
            
            let OKAction = UIAlertAction(title: "Generate Schedule", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
                self.generateSchedule()
            }
            alertController.addAction(OKAction)
            
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            }
            alertController.addAction(cancel)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue()) {
            let alertController = UIAlertController(title: "Confirm Clear", message: "Are you sure you want to unassign all shifts?", preferredStyle: UIAlertControllerStyle.Alert)
            
            let OKAction = UIAlertAction(title: "Clear Schedule", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
                self.clearSchedule()
            }
            alertController.addAction(OKAction)
            
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            }
            alertController.addAction(cancel)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
    @IBAction func segmentChanged(sender: AnyObject) {
        employeeView = !employeeView
        self.tableView.reloadData()
    }
    
    // -------
    // methods
    // -------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = schedule.name
        clearButton.enabled = !(schedule.numberOfUnassignedShifts == schedule.numberOfShifts)
        if employeeView {
            segmentedControl.selectedSegmentIndex = 1
        }
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        navigationItem.titleView?.tintColor = UIColor.whiteColor()
        generateButton.tintColor = UIColor.init(red: 71/255.0, green: 197/255.0, blue: 255.0/255.0, alpha:1)
        clearButton.tintColor = UIColor.init(red: 71/255.0, green: 197/255.0, blue: 255.0/255.0, alpha: 1)
        
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
                return schedule.numberOfUnassignedShifts
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
        if shift.assignee!.isNullEmployee {
            cell.textLabel!.textColor = UIColor.redColor()
        }
        else {
            cell.textLabel!.textColor = UIColor.blackColor()
        }
    }
    
    func buildCellEmployeeView(cell: UITableViewCell, index: NSIndexPath) {
        let emp: Employee = schedule.getEmployeeAtIndex(index.section)
        let shift: Shift! = emp.getShiftAtIndex(index.row)
        cell.textLabel!.text = days[shift.day]
        if emp.isNullEmployee {
            cell.textLabel!.textColor = UIColor.redColor()
        }
        else {
            cell.textLabel!.textColor = UIColor.blackColor()
        }
        cell.detailTextLabel!.text = shift.timeAMPM
    }
    
    // ------------
    // section name
    // ------------
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if employeeView {
            if section == schedule.nullEmployee.index {
                return "Unassigned Shifts"
            }
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
        clearButton.enabled = !(schedule.numberOfUnassignedShifts == schedule.numberOfShifts)
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
        let shiftIndex: Int! = employee.indexOfShift(shift)
        assert(shiftIndex != nil)
        let employeeIndex: Int! = employee.index
        assert(employeeIndex != nil)
        let newIndex: NSIndexPath = NSIndexPath(forRow: shiftIndex, inSection: employeeIndex)
        return newIndex
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
            let emp: Employee = schedule.getEmployeeAtIndex(index.section)
            let shift: Shift! = emp.getShiftAtIndex(index.row)
            assert(shift != nil)
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
            if let destination = segue.destinationViewController as? ShiftDetailsTableViewController {
                
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
    
    func clearSchedule() {
        schedule.clearAssignees()
        clearButton.enabled = false
        self.tableView.reloadData()
    }
    
    func generateSchedule() {
        let failures: Int = schedule.generate()
        clearButton.enabled = true
        self.tableView.reloadData()
        if failures > 0 {
            dispatch_async(dispatch_get_main_queue()) {
                let alertController = UIAlertController(title: "Scheduling Error", message: "The auto-scheduler was unable to assign an employee to \(failures) shift(s) due to time or max hours conflicts.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let cancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
                }
                alertController.addAction(cancel)
                
                self.presentViewController(alertController, animated: true, completion:nil)
            }
        }
    }
    
    @IBAction func addShiftToTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewShiftViewController, shift = sourceViewController.shift {
            addShift(shift)
        }
        if let sourceViewController = sender.sourceViewController as? DateCellTableViewController, shifts: [Shift]! = sourceViewController.shifts {
            for s in shifts {
                addShift(s)
            }
        }
    }
    
    @IBAction func deleteShiftFromTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditScheduleViewController, index = sourceViewController.index {
            removeShift(index)
        }
    }
    
}
