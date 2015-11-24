//
//  addSelectionsController.swift
//  GSA
//
//  Created by Andrew Capindo on 11/23/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit 

class addSelectionsController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newTitle: UITextField!
  
    @IBAction func add(sender: AnyObject) {
        selections.selections.append(newTitle.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        newTitle.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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