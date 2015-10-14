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
    
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var employeeLabel: UILabel!
    
    
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
        if let employee = shift._employee{
            employeeLabel.text = employee.fullName
        } else {
            employeeLabel.text = "Available"
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if (segue.identifier == "editShiftSegue") {
//            if let destination = segue.destinationViewController as? EditShiftViewController {
//                destination.shift = shift
//                destination.index = index
//            }
//        }
    }
    
    @IBAction func updateShiftDetails(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.sourceViewController as? EditScheduleViewController {
//            populateContent()
//            delegate.editCell(shift, index: index)
//        }
    }
    
}
