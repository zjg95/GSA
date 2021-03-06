//
//  EmployeeDetailsViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EmployeeDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // ------------
    // data members
    // ------------
    
    var employee: Employee!
    var index: NSIndexPath!
    var delegate: EmployeeTableViewController!
    var availableShifts: [Shift]!
    
    // -----------------
    // reference outlets
    // -----------------

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var positionTable: UITableView!
    
    // -------
    // methods
    // -------
    
    func populateContent() {
        nameLabel.text = employee.fullName
        availableShifts = employee.availability.weekToArray()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.positionTable.dataSource = self
        self.positionTable.delegate = self
        
        self.tableView.separatorStyle = .SingleLine
        self.tableView.separatorColor = UIColor.blackColor()

        // Do any additional setup after loading the view.
        populateContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editEmployeeSegue") {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let destination = nav.viewControllers.first as? EditEmployeeViewController {
                    destination.employee = employee
                    destination.index = index
                }
            }
        }
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.restorationIdentifier == "positionTable") {
            if (employee.position.count == 0) {
                return 0
            } else {
               return employee.position.count + 1
            }
        } else {
            if self.availableShifts == nil {
                return 0
            } else {
                return self.availableShifts.count + 1
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView.restorationIdentifier == "positionTable") {
            let cell = tableView.dequeueReusableCellWithIdentifier("positionCell", forIndexPath: indexPath)
            let index:Int = indexPath.row
            
            if (index == 0) {
                cell.textLabel!.text = "Title"
                cell.detailTextLabel!.text = "Level"
            } else {
                cell.textLabel!.text = employee.position[index - 1].title
                cell.detailTextLabel!.text = "\(employee.position[index - 1].level)"
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as! AvailabilityTableViewCell
        
            // Configure the cell...
            let index:Int = indexPath.row
        
            if (index == 0) {
                cell.dayLabel!.text = "Day"
                cell.timeLabel!.text = "Time"
            } else {
                let currentShift:Shift = availableShifts[index - 1]
            
                cell.dayLabel!.text = currentShift.dayToString()
                cell.timeLabel!.text = currentShift.timeAMPM
            }
            return cell
        }
    }
    
    @IBAction func updateEmployeeDetails(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditEmployeeViewController, employee = sourceViewController.employee {
            self.employee = employee
            populateContent()
            delegate.editCell(employee, index: index)
            tableView.reloadData()
            positionTable.reloadData()
        }
    }

}
