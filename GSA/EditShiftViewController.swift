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
    
    var oldShift: Shift!
    
    var staff: Staff!
    
    var employeeNames: [String] = ["None"]
    
    var alertController: UIAlertController?
    
    @IBOutlet weak var position: UILabel!
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var employeePicker: UIPickerView!
    
    @IBOutlet weak var dayPicker: UIPickerView!

    @IBOutlet weak var startPicker: UIDatePicker!
    
    @IBOutlet weak var endPicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func deleteButton(sender: AnyObject) {
        self.alertController = UIAlertController(title: "Confirm Delete", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
        })
        let delete = UIAlertAction (title: "Delete", style: .Destructive ) { alertAction in
            
            self.performSegueWithIdentifier("deleteShiftFromTableSegue", sender: self)
        }
        
        self.alertController!.addAction(cancel)
        self.alertController!.addAction(delete)
        
        presentViewController(self.alertController!, animated: true, completion: nil)
    }
    
    // -------
    // methods
    // -------
    
    func populateContent() {
        
        // day data
        dayPicker.selectRow(shift.day, inComponent: 0, animated: false)
        
        // end time data
        var calendar:NSCalendar = NSCalendar.currentCalendar()
        var date = startPicker.date
        var components = calendar.components([.Hour], fromDate: date)
        components.hour = shift.timeStart.hour
        components.minute = shift.timeStart.minutes
        startPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
        
        // end time data
        calendar = NSCalendar.currentCalendar()
        date = endPicker.date
        components = calendar.components([.Hour], fromDate: date)
        components.hour = shift.timeEnd.hour
        components.minute = shift.timeEnd.minutes
        endPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
        
        // assignee data
        
        //Gets all available employees for the current shift
//        var availableEmployees : Staff!
//        var i:Int
//        for i = 0; i < staff.count; i++ {
//            if staff[i].isAvailable(shift){
//                availableEmployees.append(staff[i])
//            }
//        }
        //replace staff below with available employees once we can assign availability to employees
        
        employeeNames += staff.employeeNames
        if let employee = oldShift.assignee {
            let index = staff.employeeIndex(employee)
            employeePicker.selectRow(index + 1, inComponent: 0, animated: false)
        }
        if shift.position != nil {
           position.text! = "Title: \(shift.position.title)     Level: \(shift.position.level)"
        } else {
            position.text! = "None"
        }
        
    }

    func extractContent() {
        shift.assignee = nil
        
        // day data
        shift.day = dayPicker.selectedRowInComponent(0)
        
        // start time data
        var calendar = NSCalendar.currentCalendar()
        var date = startPicker.date
        var components = calendar.components([.Hour], fromDate: date)
        let startHour = components.hour
        components = calendar.components([.Minute], fromDate: date)
        let startMinutes = components.minute
        shift.timeStart.hour = startHour
        shift.timeStart.minutes = startMinutes
        
        // end time data
        calendar = NSCalendar.currentCalendar()
        date = endPicker.date
        components = calendar.components([.Hour], fromDate: date)
        let endHour = components.hour
        components = calendar.components([.Minute], fromDate: date)
        let endMinutes = components.minute
        shift.timeEnd.hour = endHour
        shift.timeEnd.minutes = endMinutes
        
        // assignee data
        let index: Int = employeePicker.selectedRowInComponent(0)
        if index > 0 {
            let employee: Employee! = staff[index - 1]
            shift.assignee = employee
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        employeePicker.dataSource = self
        employeePicker.delegate = self
        dayPicker.dataSource = self
        dayPicker.delegate = self
        
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
        if dayPicker == pickerView {
            return days.count
        }
        else {
            return employeeNames.count
        }
    }
    
    //MARK: Delegates
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if dayPicker == pickerView {
            return days[row]
        }
        else {
            return employeeNames[row]
        }
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
    
    @IBAction func saveNewPosition(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditPositionForShift, position = sourceViewController.position {
            shift.position = position
            populateContent()
        }
    }
}