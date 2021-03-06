//
//  NewEmployeeViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class NewEmployeeViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // ------------
    // data members
    // ------------
    
    var employee: Employee!
    var availableShifts: [Shift]!
    var positions: [Position]!
    
    // -----------------
    // reference outlets
    // -----------------
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!

    @IBOutlet weak var positionTable: UITableView!
    
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
        if positions != nil {
            for position in positions {
                employee.position.append(position)
            }
        }
        if availableShifts != nil {
            for shift in availableShifts {
                employee.availability.append(shift)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.positionTable.dataSource = self
        self.positionTable.delegate = self
        
        self.tableView.separatorStyle = .SingleLine
        self.tableView.separatorColor = UIColor.blackColor()
        
        // Handle the text field’s user input through delegate callbacks.
        firstNameField.delegate = self
        lastNameField.delegate = self
        
        checkNameEdit()

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
        if segue.identifier == "addAvailableTime" {
            let _:NewAvailabilityViewController = segue.destinationViewController as! NewAvailabilityViewController
        }
        if segue.identifier == "addNewPosition" {
            let _:NewPosition = segue.destinationViewController as! NewPosition
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
        doneButton.enabled = ((!text.isEmpty) || (!text2.isEmpty))
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkNameEdit()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.restorationIdentifier == "Position" {
            if self.positions == nil {
                return 0
            }
            else {
               return self.positions.count + 1
            }
        } else {
            if self.availableShifts == nil {
                return 0
            } else {
                return self.availableShifts.count + 1
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.restorationIdentifier == "Position" {
            let cell = tableView.dequeueReusableCellWithIdentifier("positionCell", forIndexPath: indexPath)
            let index:Int = indexPath.row
            if (index == 0) {
                cell.textLabel!.text = "Title"
                cell.detailTextLabel!.text = "Level"
            } else {
                cell.textLabel!.text = positions[index - 1].title
                cell.detailTextLabel!.text = "\(positions[index - 1].level)"
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as! AvailabilityTableViewCell
            
            // Configure the cell...
            let index:Int = indexPath.row
            
            if (index == 0) {
                cell.dayLabel!.text = "Day"
                cell.timeLabel!.text = "Time"
            } else {
                let currentShift:Shift = availableShifts[index - 1]
                
                cell.dayLabel!.text = currentShift.dayToString()
                cell.timeLabel!.text = currentShift.timeAMPM
            }
            return cell
        }

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
    
    @IBAction func saveAvailableTime(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.sourceViewController as? NewAvailabilityViewController, shift = sourceViewController.shift {
            if availableShifts == nil {
                availableShifts = [shift]
            } else {
                availableShifts.append(shift)
            }
        }
        self.tableView.reloadData()
    }
    
    @IBAction func savePositions(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.sourceViewController as? NewPosition, position = sourceViewController.position {
            if positions == nil {
                self.positions = [position]
            }
            else {
                self.positions.append(position)
            }
        }
        self.positionTable.reloadData()
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        self.positionTable.reloadData()
    }
}
