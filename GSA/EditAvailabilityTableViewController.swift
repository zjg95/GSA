//
//  EditAvailabilityTableViewController.swift
//  GSA
//
//  Created by David Acker on 11/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EditAvailabilityTableViewController: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    var employee: Employee!
    var availableShifts: [Shift]!
    
    // -------
    // methods
    // -------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        availableShifts = employee.availability.weekToArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return availableShifts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as! AvailabilityTableViewCell
        
        // Configure the cell...
        let index:Int = indexPath.row
        let currentShift:Shift = availableShifts[index]
        
        cell.dayLabel!.text = currentShift.dayToString()
        cell.timeLabel!.text = currentShift.timeAMPM
        
        return cell
    }
    
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
    
//    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            availableShifts.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editAvailabilityDetails" {
            if let destination = segue.destinationViewController as? AvailabilityDetailsViewController {
                let index = self.tableView!.indexPathForSelectedRow
                destination.shift = self.availableShifts[index!.row]
                destination.index = index
            }
        }
    }
    
    @IBAction func addEmployeeAvailability(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewAvailabilityViewController, shift = sourceViewController.shift {
            if availableShifts == nil {
                availableShifts = [shift]
            } else {
                availableShifts.append(shift)
            }
            for shift in availableShifts {
                if !(employee.availability.contains(shift)){
                    employee.availability.append(shift)
                }
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func editEmployeeAvailability(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AvailabilityDetailsViewController, shift = sourceViewController.shift, index = sourceViewController.index {
            if availableShifts == nil {
                availableShifts = [shift]
            } else {
                availableShifts.removeAtIndex(index.row)
                availableShifts.insert(shift, atIndex: index.row)
            }
            savingAvailability()
        }
        tableView.reloadData()
    }
    
    @IBAction func deleteAvailabilityFromTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AvailabilityDetailsViewController, index = sourceViewController.index {
            availableShifts.removeAtIndex(index.row)
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Bottom)
        }
        savingAvailability()
    }
    
    func savingAvailability () {
        let holdEmployee:Employee = Employee(firstName: "Hold")
        
        for shift in availableShifts {
            holdEmployee.availability.append(shift)
        }
        
        self.employee.availability = holdEmployee.availability
    }
}