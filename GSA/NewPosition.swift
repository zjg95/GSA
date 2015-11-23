
//
//  NewPosition.swift
//  GSA
//
//  Created by Andrew Capindo on 11/22/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class NewPosition: UIViewController, UITextFieldDelegate {
    
    // ------------
    // Data Members
    // ------------
    
    var positions:[Position] = []
    
    @IBOutlet weak var newPosition: UITextField!
    
    @IBOutlet weak var level: UISlider!
    
    @IBAction func addPosition(sender: AnyObject) {
        let position = Position(title: newPosition.text!, level: level.value)
        positions.append(position)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newPosition.delegate = self
        
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
