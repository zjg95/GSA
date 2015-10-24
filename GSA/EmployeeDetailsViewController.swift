//
//  EmployeeDetailsViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {
    
    // ------------
    // data members
    // ------------
    
    var employee: Employee!
    var index: NSIndexPath!
    var delegate: EmployeeTableViewController!
    
    // -----------------
    // reference outlets
    // -----------------

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    // -------
    // methods
    // -------
    
    func populateContent() {
        nameLabel.text = employee.fullName
        positionLabel.text = employee.position
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        populateContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editEmployeeSegue") {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let destination = nav.viewControllers.first as? EditEmployeeViewController {
                    destination.employee = employee
                    destination.index = index
                }
            }
        }
    }
    
    @IBAction func updateEmployeeDetails(sender: UIStoryboardSegue) {
        populateContent()
        delegate.editCell(employee, index: index)
    }

}
