//
//  ScheduleListTableViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/24/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class ScheduleListTableViewController: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    var scheduleList: [Schedule]!
    var staff: Staff!
    
    // -------
    // methods
    // -------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        let backItem = UIBarButtonItem()
        backItem.title = "All"
        navigationItem.backBarButtonItem = backItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scheduleList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let schedule: Schedule = scheduleList[indexPath.item]
        cell.textLabel!.text = schedule.name

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            scheduleList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "scheduleSegue" {
            if let destination = segue.destinationViewController as? ScheduleTableViewController {
                let index = self.tableView!.indexPathForSelectedRow
                let week: Week = scheduleList[index!.row].week
                let staff: Staff = scheduleList[index!.row].staff
                destination.week = week
                destination.staff = staff
                destination.navigationItem.title = scheduleList[index!.row].name
            }
        }
        if segue.identifier == "newScheduleSegue" {
            if let nav = segue.destinationViewController as? UINavigationController, destination = nav.viewControllers.first as? NewScheduleViewController {
                destination.staff = self.staff
                destination.scheduleList = self.scheduleList
            }
        }
    }
    
    @IBAction func addScheduleToTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewScheduleViewController, schedule = sourceViewController.schedule {
            let newIndexPath = NSIndexPath(forRow: scheduleList.count, inSection: 0)
            scheduleList.append(schedule)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }

}
