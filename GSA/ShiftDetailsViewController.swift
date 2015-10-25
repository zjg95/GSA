//
//  ShiftDetailsViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/12/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class ShiftDetailsViewController: UIViewController {
    
    // ------------
    // data members
    // ------------
    
    var shift: Shift!
    var delegate: ShiftTableViewController!
    var index: NSIndexPath!
    
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var shiftLabel: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    
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
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editShiftSegue") {
            if let destination = segue.destinationViewController as? EditShiftViewController {
                destination.shift = shift
                destination.index = index
            }
        }
    }
    
//    @IBAction func updateShiftDetails(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.sourceViewController as? EditShiftViewController {
//            populateContent()
//            delegate.editCell(shift, index: index)
//        }
//    }

}
