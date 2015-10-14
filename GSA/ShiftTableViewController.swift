//
//  ShiftTableViewController.swift
//  GSA
//
//  Created by Andrew Capindo on 10/12/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class ShiftTableViewController: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    var sectionDay: [String] = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
    ]
    
    var shiftCells: [[Shift]] = [
        [Shift(timeStart: 6, timeEnd: 10, day: 0)]
    ]
    
    // -------
    // methods
    // -------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return shiftCells.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shiftCells[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let shift: Shift = shiftCells[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("shiftCell", forIndexPath: indexPath)
        cell.textLabel!.text = String(shift.timeAMPM)
        cell.detailTextLabel?.text = String(shift.duration)
        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionDay[section]
    }
    
    func editCell(shift: Shift, index: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(index)
        cell?.textLabel?.text = shift.timeAMPM
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "shiftDetailsSegue") {
            if let destination = segue.destinationViewController as? ShiftDetailsViewController {
                let index = self.tableView!.indexPathForSelectedRow
                destination.shift = self.shiftCells[index!.section][index!.row]
                destination.index = index
                destination.delegate = self
            }
        }
    }
    
    @IBAction func addShiftToTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewShiftViewController, shift = sourceViewController.shift {
            print("new shift added")
            // add shift to data array
            // add shift to table
            let newIndexPath = NSIndexPath(forRow: shiftCells[shift.day - 1].count, inSection: shift.day - 1)
            shiftCells[shift.day - 1].append(shift)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    
    @IBAction func deleteShiftFromTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditShiftViewController, index = sourceViewController.index {
            print("shift deleted")
            // delete shift from data array
            // delete shift from table
            shiftCells[index.section].removeAtIndex(index.row)
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Bottom)
            if tableView.numberOfRowsInSection(index.section) == 0 {
                // delete empty section, the following line causes a crash
                shiftCells.removeAtIndex(index.section)
                tableView.deleteSections(NSIndexSet(index: index.section), withRowAnimation: .Bottom)
            }
        }
    }
}
