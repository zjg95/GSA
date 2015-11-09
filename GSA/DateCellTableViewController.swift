//
//  DateCellTableViewController.swift
//  DateCell
//
//  Created by Kohei Hayakawa on 2/6/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class DateCellTableViewController: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    let kPickerAnimationDuration = 0.40 // duration for the animation to slide the date picker into view
    let kDatePickerTag           = 99   // view tag identifiying the date picker view
    
    let kTitleKey = "title" // key for obtaining the data source item's title
    let kDateKey  = "date"  // key for obtaining the data source item's date value
    let kIndexKey = "index" // key for obtaining the index
    
    // keep track of which rows have date cells
    let kDateStartRow = 0
    let kDateEndRow   = 1
    
    let kDateCellID       = "dateCell";       // the cells with the start or end date
    let kDatePickerCellID = "datePickerCell"; // the cell containing the date picker
    let kOtherCellID      = "otherCell";      // the remaining cells at the end

    var dataArray: [[String: AnyObject]] = []
    var dateFormatter = NSDateFormatter()
    
    // keep track which indexPath points to the cell with UIDatePicker
    var datePickerIndexPath: NSIndexPath?
    
    var pickerCellRowHeight: CGFloat = 216
    
    var dayBools: [Bool] = [Bool](count: 7, repeatedValue: true)
    
    var shifts: [Shift] = []
    
    // -------
    // outlets
    // -------
    
    @IBOutlet var pickerView: UIDatePicker!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func cancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // -------
    // methods
    // -------
    
    func extractContent() {
        var calendar = NSCalendar.currentCalendar()
        var date = dataArray[0][kDateKey] as! NSDate
        var components = calendar.components([.Hour], fromDate: date)
        
        let startHour = components.hour
        components = calendar.components([.Minute], fromDate: date)
        let startMinutes = components.minute
        
        calendar = NSCalendar.currentCalendar()
        date = dataArray[1][kDateKey] as! NSDate
        components = calendar.components([.Hour], fromDate: date)
        
        let endHour = components.hour
        components = calendar.components([.Minute], fromDate: date)
        let endMinutes = components.minute
        
        for var i = 0; i < 7; ++i {
            if dayBools[i] {
                shifts.append(Shift(timeStart: Time(hour: startHour, minutes: startMinutes), timeEnd: Time(hour: endHour, minutes: endMinutes), day: i))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayBools[0] = true

        // setup our data source
        let itemTwo = [kTitleKey : "Start Time", kDateKey : NSDate()]
        let itemThree = [kTitleKey : "End Time", kDateKey : NSDate()]
        let itemFour = [kTitleKey : "Day", kIndexKey : [0]]
        let itemFive = [kTitleKey : "Duration"]
        dataArray = [itemTwo, itemThree, itemFour, itemFive]
        
        dateFormatter.timeStyle = .ShortStyle
    }

    /*! Determines if the given indexPath has a cell below it with a UIDatePicker.
    
    @param indexPath The indexPath to check if its cell has a UIDatePicker below it.
    */
    func hasPickerForIndexPath(indexPath: NSIndexPath) -> Bool {
        var hasDatePicker = false
        
        let targetedRow = indexPath.row + 1
        
        let checkDatePickerCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: targetedRow, inSection: 0))
        let checkDatePicker = checkDatePickerCell?.viewWithTag(kDatePickerTag)
        
        hasDatePicker = checkDatePicker != nil
        return hasDatePicker
    }

    // Updates the UIDatePicker's value to match with the date of the cell above it.
    func updateDatePicker() {
        if let indexPath = datePickerIndexPath {
            let associatedDatePickerCell = tableView.cellForRowAtIndexPath(indexPath)
            if let targetedDatePicker = associatedDatePickerCell?.viewWithTag(kDatePickerTag) as! UIDatePicker? {
                let itemData = dataArray[self.datePickerIndexPath!.row - 1]
                targetedDatePicker.setDate(itemData[kDateKey] as! NSDate, animated: false)
            }
        }
    }
    
    // Determines if the UITableViewController has a UIDatePicker in any of its cells.
    func hasInlineDatePicker() -> Bool {
        return datePickerIndexPath != nil
    }
    
    // Determines if the given indexPath points to a cell that contains the UIDatePicker.
    // @param indexPath The indexPath to check if it represents a cell with the UIDatePicker
    func indexPathHasPicker(indexPath: NSIndexPath) -> Bool {
        return hasInlineDatePicker() && datePickerIndexPath?.row == indexPath.row
    }

    // Determines if the given indexPath points to a cell that contains the start/end dates.
     // @param indexPath The indexPath to check if it represents start/end date cell.
    func indexPathHasDate(indexPath: NSIndexPath) -> Bool {
        var hasDate = false
        
        if (indexPath.row == kDateStartRow) || (indexPath.row == kDateEndRow || (hasInlineDatePicker() && (indexPath.row == kDateEndRow + 1))) {
            hasDate = true
        }
        return hasDate
    }

    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (indexPathHasPicker(indexPath) ? pickerCellRowHeight : tableView.rowHeight)
    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        if hasInlineDatePicker() {
            // we have a date picker, so allow for it in the number of rows in this section
            var numRows = dataArray.count
            return ++numRows;
        }
        
        return dataArray.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        var cellID = kOtherCellID
        
        if indexPathHasPicker(indexPath) {
            // the indexPath is the one containing the inline date picker
            cellID = kDatePickerCellID     // the current/opened date picker cell
        } else if indexPathHasDate(indexPath) {
            // the indexPath is one that contains the date information
            cellID = kDateCellID       // the start/end date cells
        }
        
        cell = tableView.dequeueReusableCellWithIdentifier(cellID)
    
        if indexPath.row == 3 {
            // we decide here that first cell in the table is not selectable (it's just an indicator)
            cell?.selectionStyle = .None
            cell?.userInteractionEnabled = false
            cell?.detailTextLabel?.text = "8 hours"
        }
        else if indexPath.row == 2 {
            cell?.detailTextLabel?.text = "Sunday"
        }
        
        // if we have a date picker open whose cell is above the cell we want to update,
        // then we have one more cell than the model allows
        //
        var modelRow = indexPath.row
        if (datePickerIndexPath != nil && datePickerIndexPath?.row <= indexPath.row) {
            modelRow--
        }
        
        let itemData = dataArray[modelRow]
        
        if cellID == kDateCellID {
            // we have either start or end date cells, populate their date field
            //
            cell?.textLabel?.text = itemData[kTitleKey] as? String
            cell?.detailTextLabel?.text = self.dateFormatter.stringFromDate(itemData[kDateKey] as! NSDate)
        } else if cellID == kOtherCellID {
            // this cell is a non-date cell, just assign its text label
            //
            cell?.textLabel?.text = itemData[kTitleKey] as? String
        }
        
        return cell!
    }
    
    /*! Adds or removes a UIDatePicker cell below the given indexPath.
    
    @param indexPath The indexPath to reveal the UIDatePicker.
    */
    func toggleDatePickerForSelectedIndexPath(indexPath: NSIndexPath) {
        
        tableView.beginUpdates()
        
        let indexPaths = [NSIndexPath(forRow: indexPath.row + 1, inSection: 0)]
        
        // check if 'indexPath' has an attached date picker below it
        if hasPickerForIndexPath(indexPath) {
            // found a picker below it, so remove it
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        } else {
            // didn't find a picker below it, so we should insert it
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        }
        tableView.endUpdates()
    }

    /*! Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
    
    @param indexPath The indexPath to reveal the UIDatePicker.
    */
    func displayInlineDatePickerForRowAtIndexPath(indexPath: NSIndexPath) {
        
        // display the date picker inline with the table content
        tableView.beginUpdates()
        
        var before = false // indicates if the date picker is below "indexPath", help us determine which row to reveal
        if hasInlineDatePicker() {
            before = datePickerIndexPath?.row < indexPath.row
        }
        
        let sameCellClicked = (datePickerIndexPath?.row == indexPath.row + 1)
        
        // remove any date picker cell if it exists
        if self.hasInlineDatePicker() {
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: datePickerIndexPath!.row, inSection: 0)], withRowAnimation: .Fade)
            datePickerIndexPath = nil
        }
        
        if !sameCellClicked {
            // hide the old date picker and display the new one
            let rowToReveal = (before ? indexPath.row - 1 : indexPath.row)
            let indexPathToReveal = NSIndexPath(forRow: rowToReveal, inSection: 0)
            
            toggleDatePickerForSelectedIndexPath(indexPathToReveal)
            datePickerIndexPath = NSIndexPath(forRow: indexPathToReveal.row + 1, inSection: 0)
        }
        
        // always deselect the row containing the start or end date
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        
        tableView.endUpdates()
        
        // inform our date picker of the current date to match the current cell
        updateDatePicker()
    }
    
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.reuseIdentifier == kDateCellID {
            displayInlineDatePickerForRowAtIndexPath(indexPath)
        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    // MARK: - Actions
    
    /*! User chose to change the date by changing the values inside the UIDatePicker.
    
    @param sender The sender for this action: UIDatePicker.
    */
    
    
    @IBAction func dateAction(sender: UIDatePicker) {
        
        var targetedCellIndexPath: NSIndexPath?
        
        if self.hasInlineDatePicker() {
            // inline date picker: update the cell's date "above" the date picker cell
            //
            targetedCellIndexPath = NSIndexPath(forRow: datePickerIndexPath!.row - 1, inSection: 0)
        } else {
            // external date picker: update the current "selected" cell's date
            targetedCellIndexPath = tableView.indexPathForSelectedRow
        }
        
        let cell = tableView.cellForRowAtIndexPath(targetedCellIndexPath!)
        let targetedDatePicker = sender
        
        // update our data model
        var itemData = dataArray[targetedCellIndexPath!.row]
        itemData[kDateKey] = targetedDatePicker.date
        dataArray[targetedCellIndexPath!.row] = itemData
        
        // update the cell's date string
        cell?.detailTextLabel?.text = dateFormatter.stringFromDate(targetedDatePicker.date)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton == sender as? UIBarButtonItem {
            extractContent()
        }
        else if let destination = segue.destinationViewController as? DayPickerTableViewController {
            destination.delegate = self
        }
    }

}
