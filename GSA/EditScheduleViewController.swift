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
    
    let pickerData: [String] = [
        "John",
        "Bob",
        "Nancy",
        "Fred"
    ]
    
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var employeePicker: UIPickerView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // -------
    // methods
    // -------
    
//    func populateContent() {
//        dayPicker.selectRow(shift.day, inComponent: 0, animated: false)
//        
//        // Sets Start Time for Picker
//        var calendar:NSCalendar = NSCalendar.currentCalendar()
//        var date = startPicker.date
//        var components = calendar.components([.Hour], fromDate: date)
//        components.hour = shift.timeStart
//        components.minute = 0
//        startPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
//        
//        // Sets End Time for Picker
//        calendar = NSCalendar.currentCalendar()
//        date = endPicker.date
//        components = calendar.components([.Hour], fromDate: date)
//        components.hour = shift.timeEnd
//        components.minute = 0
//        endPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
//        
//    }
//
//    func extractContent() {
//        shift.day = dayPicker.selectedRowInComponent(0)
//        var calendar = NSCalendar.currentCalendar()
//        var date = startPicker.date
//        var components = calendar.components([.Hour], fromDate: date)
//        
//        let startHour = components.hour
//        
//        calendar = NSCalendar.currentCalendar()
//        date = endPicker.date
//        components = calendar.components([.Hour], fromDate: date)
//        
//        let endHour = components.hour
//        
//        shift.timeStart = startHour
//        shift.timeEnd = endHour
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        employeePicker.dataSource = self
        employeePicker.delegate = self
        
        //populateContent()
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
            //extractContent()
        }
    }
}