//
//  ScheduleDetailsViewController.swift
//  GSA
//
//  Created by David Acker on 10/14/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation
import UIKit

class ScheduleDetailsViewController: UIViewController {
    
    // ------------
    // data members
    // ------------
    
    var shift: Shift!
    var delegate: ScheduleTableViewController!
    var index: NSIndexPath!
    
    var staff: Staff!
    
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var shiftLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var assigneeLabel: UILabel!
    
    // -------
    // methods
    // -------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        populateContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateContent() {
        dayLabel.text   = days[shift.day]
        shiftLabel.text = shift.timeAMPM
        hoursLabel.text = "Hours: " + String(shift.duration)
        if let employee = shift._employee {
            assigneeLabel.text! = employee.fullName
        } else {
            assigneeLabel.text! = "None"
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editScheduleSegue") {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let destination = nav.viewControllers.first as? EditScheduleViewController {
                    destination.staff = self.staff
                    destination.shift = shift
                }
            }
        }
    }
    
    @IBAction func updateShiftDetails(sender: UIStoryboardSegue) {
        populateContent()
        delegate.editCell(shift, index: index)
    }
    
}
