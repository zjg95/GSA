//
//  ShiftDetailsTableViewController.swift
//  GSA
//
//  Created by Zach Goodman on 11/23/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class ShiftDetailsTableViewController: UITableViewController {
    
    // ------------
    // data members
    // ------------
    
    var shift: Shift!
    var delegate: ScheduleTableViewController!
    var index: NSIndexPath!
    
    var staff: Staff!
    
    // -------
    // outlets
    // -------
    
    @IBOutlet weak var dayCell: UITableViewCell!
    @IBOutlet weak var shiftCell: UITableViewCell!
    @IBOutlet weak var durationCell: UITableViewCell!
    @IBOutlet weak var assigneeCell: UITableViewCell!
    
    // -------
    // methods
    // -------
    
    func populateContent() {
        dayCell.detailTextLabel?.text = days[shift.day]
        shiftCell.detailTextLabel?.text = shift.timeAMPM
        durationCell.detailTextLabel?.text = String(shift.duration)
        assert(shift.assignee != nil)
        assigneeCell.detailTextLabel?.text = shift.assignee!.fullName
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        populateContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editScheduleSegue") {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let destination = nav.viewControllers.first as? EditScheduleViewController {
                    destination.staff = self.staff
                    destination.shift = shift.copy()
                    destination.oldShift = shift
                    destination.index = self.index
                }
            }
        }
    }
    
    @IBAction func updateShiftDetails(sender: UIStoryboardSegue) {
        if let source = sender.sourceViewController as? EditScheduleViewController, thatShift = source.shift {
            assert(delegate != nil)
            delegate.editShift(shift, newShift: thatShift, oldIndex: index)
            populateContent()
        }
    }

}
