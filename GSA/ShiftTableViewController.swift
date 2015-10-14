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
        [
            Shift(timeStart: 9, timeEnd: 17, day: 0)
        ],
        [
            Shift(timeStart: 7, timeEnd: 11, day: 1),
            Shift(timeStart: 9, timeEnd: 12, day: 1)
        ],
        [
            Shift(timeStart: 7, timeEnd: 11, day: 2)
        ],
        [
        ],
        [
        ],
        [
        ],
        [
        ]
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
        return 7
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
        let day = shift.day
        if day != index.section {
            // shift was moved to another day
            deleteShift(index)
            addShift(shift)
        }
        else {
            // shift time has changed
            let cell = tableView.cellForRowAtIndexPath(index)
            cell?.textLabel?.text = shift.timeAMPM
        }
    }
    
    func addShift(shift: Shift) {
        print("new shift added")
        // add shift to data array
        // add shift to table
        let newIndexPath = NSIndexPath(forRow: shiftCells[shift.day].count, inSection: shift.day)
        shiftCells[shift.day].append(shift)
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
    }
    
    func deleteShift(index: NSIndexPath) {
        print("shift deleted")
        // delete shift from data array
        // delete shift from table
        shiftCells[index.section].removeAtIndex(index.row)
        tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Bottom)
        if tableView.numberOfRowsInSection(index.section) == 0 {
            // delete empty section, the following line causes a crash
            //tableView.deleteSections(NSIndexSet(index: index.section), withRowAnimation: .Bottom)
        }
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
            addShift(shift)
        }
    }
    
    @IBAction func deleteShiftFromTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditShiftViewController, index = sourceViewController.index {
            deleteShift(index)
        }
    }
}
