//
//  NewEmployeeViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class NewEmployeeViewController: UIViewController {
    
    // ------------
    // data members
    // ------------
    
    var employee: Employee!
    
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // -------
    // methods
    // -------
    
    func extractContent() {
        let firstName: String = firstNameField.text!
        let lastName: String = lastNameField.text!
        employee = Employee(firstName: firstName, lastName: lastName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        if doneButton == (sender as? UIBarButtonItem) {
            extractContent()
        }
    }

}
