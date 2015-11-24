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
    
    func saveChanges() {
        
    }
}
