//
//  EditEmployeeViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/9/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EditEmployeeViewController: UIViewController, UITextFieldDelegate {
    
    // ------------
    // data members
    // ------------
    
    var employee: Employee!
    var index: NSIndexPath!
    
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBAction func deleteButton(sender: AnyObject) {
    }
    
    // -------
    // methods
    // -------
    
    func populateData() {
        firstNameField.text = employee.firstName
        lastNameField.text = employee.lastName
    }
    
    func extractContent() {
        employee.firstName = firstNameField.text!
        employee.lastName = lastNameField.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field’s user input through delegate callbacks.
        firstNameField.delegate = self
        lastNameField.delegate = self
        
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
        navigationItem.title = textField.text
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
