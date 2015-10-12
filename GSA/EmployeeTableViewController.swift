//
//  EmployeeTableViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EmployeeTableViewController: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    var employeeList: [Employee] = [
        Employee(firstName: "Gus", lastName: "Ortiz")
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return employeeList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let e = employeeList[indexPath.item]
        cell.textLabel?.text = e.fullName

        return cell
    }
    
    func editCell(employee: Employee, index: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(index)
        cell?.textLabel?.text = employee.fullName
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "employeeDetailsSegue") {
            if let destination = segue.destinationViewController as? EmployeeDetailsViewController {
                let index = self.tableView!.indexPathForSelectedRow
                destination.employee = self.employeeList[index!.row]
                destination.index = index
                destination.delegate = self
            }
        }
    }
    
    @IBAction func unwindToEmployeeList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewEmployeeViewController, employee = sourceViewController.employee {
            let newIndexPath = NSIndexPath(forRow: employeeList.count, inSection: 0)
            employeeList.append(employee)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    
    @IBAction func deleteEmployeeFromTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditEmployeeViewController, index = sourceViewController.index {
            employeeList.removeAtIndex(index.row)
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Bottom)
        }
    }

}
