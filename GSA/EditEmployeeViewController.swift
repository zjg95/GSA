//
//  EditEmployeeViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EditEmployeeViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // ------------
    // data members
    // ------------
    
    var employee: Employee!
    var index: NSIndexPath!
    var alertController:UIAlertController? = nil
    var availableShifts: [Shift]!
    
    // -----------------
    // reference outlets
    // -----------------
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var positionField: UITextField!
    
    @IBAction func deleteButton(sender: AnyObject) {
        self.alertController = UIAlertController(title: "Confirm Delete", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
        })
        let delete = UIAlertAction (title: "Delete", style: .Destructive ) { alertAction in
            
            self.performSegueWithIdentifier("deleteEmployeeFromTableSegue", sender: self)
        }
        
        self.alertController!.addAction(cancel)
        self.alertController!.addAction(delete)
        
        presentViewController(self.alertController!, animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // -------
    // methods
    // -------
    
    func populateData() {
        firstNameField.text = employee.firstName
        lastNameField.text = employee.lastName
        positionField.text = employee.position
    }
    
    func extractContent() {
        employee.firstName = firstNameField.text!
        employee.lastName = lastNameField.text!
        employee.position = positionField.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field’s user input through delegate callbacks.
        firstNameField.delegate = self
        lastNameField.delegate = self
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.separatorStyle = .SingleLine
        self.tableView.separatorColor = UIColor.blackColor()
        
        // Do any additional setup after loading the view.
        checkNameEdit()
        populateData()
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
        if doneButton == sender as? UIBarButtonItem {
            extractContent()
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    // Disable the Done button while editing.
    func textFieldDidBeginEditing(textField: UITextField) {
        doneButton.enabled = false
    }
    
    //Disable the Done button until name has been changed
    func checkNameEdit() {
        // Disable the Save button if the text field is empty.
        let text = firstNameField.text ?? ""
        let text2 = lastNameField.text ?? ""
        doneButton.enabled = (!text.isEmpty) || (!text2.isEmpty)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkNameEdit()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.availableShifts == nil {
            return 0
        } else {
            return self.availableShifts.count + 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as! AvailabilityTableViewCell
        
        // Configure the cell...
        let index:Int = indexPath.row
        
        if (index == 0) {
            cell.dayLabel!.text = "Day"
            cell.timeLabel!.text = "Time"
        } else {
            //availableShifts = employee.shifts.weekToArray()
            let currentShift:Shift = availableShifts[index - 1]
            
            cell.dayLabel!.text = currentShift.dayToString()
            cell.timeLabel!.text = currentShift.timeAMPM
        }
        
        return cell
    }

    
    // This method is called when the user touches the Return key on the
    // keyboard. The 'textField' passed in is a pointer to the textField
    // widget the cursor was in at the time they touched the Return key on
    // the keyboard.
    //
    // From the Apple documentation: Asks the delegate if the text field
    // should process the pressing of the return button.
    //
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
}
