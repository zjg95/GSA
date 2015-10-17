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
    
    var week: Week!
    
    var staff: Staff!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func sortControl(sender: AnyObject) {
        print("segmented control pressed")
    }
    
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
        return days.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return week[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let shift: Shift = week[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
        cell.textLabel!.text = String(shift.timeAMPM)
        if let employee = shift._employee {
            cell.detailTextLabel?.text = employee.fullName
        } else {
            cell.detailTextLabel?.text = "Unassigned"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section]
    }
    
    func editCell(shift: Shift, index: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(index)
        if let employee = shift._employee {
            cell?.detailTextLabel?.text = employee.fullName
        }
        else {
            cell?.detailTextLabel?.text = "Unassigned"
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
                destination.shift = week[index!.section][index!.row]
                destination.staff = staff
            }
        }
    }
}
