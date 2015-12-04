//
//  EditPositionTableViewController.swift
//  GSA
//
//  Created by Andrew Capindo on 11/24/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EditPositionTableViewController: UITableViewController {
    
    var positions:[Position]!
    var position:Position!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if positions == nil {
            return 1
        }
        else {
            return positions.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("positionCell", forIndexPath: indexPath)
        let index:Int = indexPath.row
        if positions != nil {
            cell.textLabel!.text = positions[index].title
            cell.detailTextLabel!.text = "\(positions[index].level)"
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "edit" {
            if let destination = segue.destinationViewController as? EditPositionController {
                let index = self.tableView!.indexPathForSelectedRow
                destination.position = positions[index!.row]
                destination.index = index
            }
        }
    }
    
    @IBAction func saveEditChanges(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditPositionController, position = sourceViewController.position, index = sourceViewController.index {
            positions[index.row] = position
        }
        tableView.reloadData()
    }
    
    @IBAction func saveNewPosition(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddPositionController, position = sourceViewController.newPosition {
            positions.append(position)
        }
        tableView.reloadData()
    }
    
    @IBAction func deletePositionFromTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditPositionController, index = sourceViewController.index {
            positions.removeAtIndex(index.row)
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Bottom)
        }
        tableView.reloadData()
    }
    
    @IBAction func cancel(sender: UIStoryboardSegue) {
        tableView.reloadData()
    }
}
