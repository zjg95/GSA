//
//  ViewController.swift
//  SegFault11
//
//  Created by Dylan Vann on 2014-10-25.
//  Copyright (c) 2014 Dylan Vann. All rights reserved.
//

import UIKit

class NewShiftTableViewController2: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    let reuse: String? = "cell"

    var cells: NSMutableArray = NSMutableArray()
    
    // -------
    // outlets
    // -------
    
    @IBAction func cancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // -------
    // methods
    // -------
    
    func populateContent() {
        
    }
    
    func extractContent() {
        
    }
    
    override func viewDidLoad() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        
        // The DatePickerCell.
        let datePickerCell = DatePickerCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        // Cells is a 2D array containing sections and rows.
        cells.addObject(NSMutableArray())
        cells[0].addObject(datePickerCell)
        cells[0].addObject(DatePickerCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil))
        
        cells.addObject(NSMutableArray())
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuse)
        cell.textLabel?.text = "test"
        
        cells[1].addObject(cell)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Get the correct height if the cell is a DatePickerCell.
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if (cell.isKindOfClass(DatePickerCell)) {
            return (cell as! DatePickerCell).datePickerHeight()
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Deselect automatically if the cell is a DatePickerCell.
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if (cell.isKindOfClass(DatePickerCell)) {
            let datePickerTableViewCell = cell as! DatePickerCell
            datePickerTableViewCell.selectedInTableView(tableView)
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cells.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row] as! UITableViewCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if doneButton == sender as? UIBarButtonItem {
            extractContent()
        }
    }
}