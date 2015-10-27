//
//  NewScheduleViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/25/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class NewScheduleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ------------
    // data members
    // ------------
    
    var schedule: Schedule!
    var scheduleList: [Schedule]!
    var staff: Staff!
    
    // -------
    // outlets
    // -------

    @IBOutlet weak var schedulePicker: UIPickerView!
    
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
        var week: Week!
        let selection = schedulePicker.selectedRowInComponent(0)
        if selection > 0 {
            week = scheduleList[selection - 1].week.copy()
        }
        else {
            week = Week()
        }
        schedule = Schedule(name: name, staff: staff.copy(), week: week)
        schedule.clearAssignees()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        schedulePicker.dataSource = self
        schedulePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Data Sources
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scheduleList.count + 1
    }
    
    //MARK: Delegates
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "None"
        }
        return scheduleList[row - 1].name
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
