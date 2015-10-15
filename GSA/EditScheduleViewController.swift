//
//  EditScheduleViewController.swift
//  GSA
//
//  Created by David Acker on 10/14/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation
import UIKit

class EditScheduleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ------------
    // data members
    // ------------
    
    var index: NSIndexPath!
    
    var shift: Shift!
    
    var staff: Staff!
    
    var pickerData: [String] = ["None"]
    
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var employeePicker: UIPickerView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // -------
    // methods
    // -------
    
    func populateContent() {
        pickerData += staff.employeeNames
        if let employee = shift._employee {
            let index = staff.employeeIndex(employee)
            employeePicker.selectRow(index + 1, inComponent: 0, animated: false)
        }
    }

    func extractContent() {
        let index: Int = employeePicker.selectedRowInComponent(0)
        if index > 0 {
            let employee: Employee! = staff[index - 1]
            shift._employee = employee
        }
        else {
            shift._employee = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        employeePicker.dataSource = self
        employeePicker.delegate = self
        
        populateContent()
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
        return pickerData.count
    }
    
    //MARK: Delegates
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        myLabel.text = pickerData[row]
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