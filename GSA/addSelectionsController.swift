//
//  addSelectionsController.swift
//  GSA
//
//  Created by Andrew Capindo on 11/23/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit 

class addSelectionsController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private var titles = selections.selections
    
    private var alertController:UIAlertController? = nil
    
    @IBOutlet weak var newTitle: UITextField!

    @IBAction func saveTitle(sender: AnyObject) {
        for t in titles {
            if newTitle!.text == t {
                self.alertController = UIAlertController(title: "Title Already Exists", message: "Try a different title", preferredStyle: UIAlertControllerStyle.Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
                }
                self.alertController!.addAction(OKAction)
                
                self.presentViewController(self.alertController!, animated: true, completion:nil)
                
                newTitle.text = ""
            }
        }
        selections.selections.append(newTitle.text!)
        titles.append(newTitle.text!)
        titlesTable.reloadData()
    }
    
    @IBOutlet weak var titlesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        newTitle.delegate = self
        self.titlesTable.dataSource = self
        self.titlesTable.delegate = self
        
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
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)
        let index:Int = indexPath.row
        cell.textLabel!.text = titles[index]
        return cell
    }

}