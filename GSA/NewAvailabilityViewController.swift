//
//  NewAvailabilityViewController.swift
//  GSA
//
//  Created by David Acker on 11/4/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation
import UIKit

class NewAvailabilityViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ------------
    // data members
    // ------------
    
    var shift: Shift!
    
    // -----------------
    // reference outlets
    // -----------------
    
    @IBOutlet weak var startPicker: UIDatePicker!
    
    @IBOutlet weak var endPicker: UIDatePicker!
    
    @IBOutlet weak var dayPicker: UIPickerView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButton(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    // -------
    // methods
    // -------
    
    func populateContent() {
        // Sets Start Time for Picker
        var calendar:NSCalendar = NSCalendar.currentCalendar()
        var date = startPicker.date
        var components = calendar.components([.Hour], fromDate: date)
        components.hour = 9
        components.minute = 0
        startPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
        
        // Sets End Time for Picker
        calendar = NSCalendar.currentCalendar()
        date = endPicker.date
        components = calendar.components([.Hour], fromDate: date)
        components.hour = 17
        components.minute = 0
        endPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
    }
    
    func extractContent() {
        // Gets Day for Availability
        let day = dayPicker.selectedRowInComponent(0)
        
        
        // Get Starting time in hrs and mins
        var calendar = NSCalendar.currentCalendar()
        var date = startPicker.date
        var components = calendar.components([.Hour, .Minute], fromDate: date)
        let startHour = components.hour
        let startMinutes = components.minute
        
        // Get Ending time in hrs and mins
        calendar = NSCalendar.currentCalendar()
        date = endPicker.date
        components = calendar.components([.Hour, .Minute], fromDate: date)
        let endHour = components.hour
        let endMinutes = components.minute
        
        shift = Shift(timeStart: Time(hour:startHour, minutes:startMinutes), timeEnd: Time(hour:endHour, minutes: endMinutes), day: day)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        return days.count
    }
    
    //MARK: Delegates
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        //        myLabel.text = pickerData[row]
//    }
    
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
