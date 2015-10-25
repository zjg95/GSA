//
//  NewScheduleViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/25/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class NewScheduleViewController: UIViewController {
    
    // ------------
    // data members
    // ------------
    
    var schedule: Schedule!
    
    // -------
    // outlets
    // -------

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // -------
    // methods
    // -------
    
    func extractContent() {
        let name: String = nameField.text!
        let week: Week = Week()
        schedule = Schedule(name: name, staff: Staff(), week: week)
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
        if saveButton == sender as? UIBarButtonItem {
            extractContent()
        }
    }

}
