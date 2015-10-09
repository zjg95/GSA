//
//  EmployeeDetailsViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {
    
    var employee : Employee!

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = employee.firstName + " " + employee.lastName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
