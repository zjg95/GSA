//
//  DayPickerTableViewController.swift
//  GSA
//
//  Created by Zach Goodman on 11/8/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class DayPickerTableViewController: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    var delegate: DateCellTableViewController!
    
    // -------
    // methods
    // -------

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row: Int = indexPath.row
        delegate.dayBools[row] = !delegate.dayBools[row]
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.textLabel?.text = getText(row)
    }
    
    private func getText(index: Int) -> String {
        var text: String = days[index]
        if delegate.dayBools[index] {
            text += " ✓"
        }
        return text
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = getText(indexPath.row)
        cell.selectionStyle = .None

        return cell
    }

}
