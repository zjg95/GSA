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
    
    var staff: Staff!
    
    // -------
    // methods
    // -------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longpress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        
        tableView.addGestureRecognizer(longpress)

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
        return staff.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let e = staff[indexPath.item]
        cell.textLabel?.text = e.fullName
//        cell.detailTextLabel?.text = e.position

        return cell
    }
    
    func editCell(employee: Employee, index: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(index)
        cell?.textLabel?.text = employee.fullName
//        cell!.detailTextLabel?.text = employee.position
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
                destination.employee = staff[index!.row]
//                print(staff[index!.row].position[0].title)
                destination.index = index
                destination.delegate = self
            }
        }
    }
    
    @IBAction func addEmployeeToTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewEmployeeViewController, employee = sourceViewController.employee {
            let newIndexPath = NSIndexPath(forRow: staff.count, inSection: 0)
            staff.append(employee)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    
    @IBAction func deleteEmployeeFromTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditEmployeeViewController, index = sourceViewController.index {
            staff.removeAtIndex(index.row)
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Bottom)
        }
    }
    
    //Function to move cells via a long press
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(locationInView)
        
        struct My {
            
            static var cellSnapshot : UIView? = nil
            
        }
        struct Path {
            
            static var initialIndexPath : NSIndexPath? = nil
            
        }
        
        switch state {
            case UIGestureRecognizerState.Began:
                if indexPath != nil {
                    Path.initialIndexPath = indexPath
                    let cell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
                    My.cellSnapshot  = snapshopOfCell(cell)
                    var center = cell.center
                
                    My.cellSnapshot!.center = center
                
                    My.cellSnapshot!.alpha = 0.0
                
                    tableView.addSubview(My.cellSnapshot!)
                
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        center.y = locationInView.y
                    
                        My.cellSnapshot!.center = center
                    
                        My.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    
                        My.cellSnapshot!.alpha = 0.98
                    
                        cell.alpha = 0.0
                    
                        }, completion: { (finished) -> Void in
                        
                            if finished {
                            
                                cell.hidden = true
                            
                            }
                    })
                
                }
            case UIGestureRecognizerState.Changed:
                var center = My.cellSnapshot!.center
                center.y = locationInView.y
                My.cellSnapshot!.center = center
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    swap(&staff[indexPath!.row], &staff[Path.initialIndexPath!.row])
                    tableView.moveRowAtIndexPath(Path.initialIndexPath!, toIndexPath: indexPath!)
                    Path.initialIndexPath = indexPath
                }
            default:
                let cell = tableView.cellForRowAtIndexPath(Path.initialIndexPath!) as UITableViewCell!
                cell.hidden = false
                cell.alpha = 0.0
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = cell.center
                    My.cellSnapshot!.transform = CGAffineTransformIdentity
                    My.cellSnapshot!.alpha = 0.0
                    cell.alpha = 1.0
                    }, completion: { (finished) -> Void in
                        if finished {
                            Path.initialIndexPath = nil
                            My.cellSnapshot!.removeFromSuperview()
                            My.cellSnapshot = nil
                        }
                })
        }
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
}
