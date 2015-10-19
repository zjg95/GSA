//
//  EditShiftViewController.swift
//  GSA
//
//  Created by Zach Goodman on 10/12/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EditShiftViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ------------
    // data members
    // ------------
    
    var index: NSIndexPath!
    
    var shift: Shift!
    
    var alertController: UIAlertController?
    
    // -----------------
    // reference outlets
    // -----------------

    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func deleteShiftButton(sender: AnyObject) {
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
        dayPicker.selectRow(shift.day, inComponent: 0, animated: false)
        
        // Sets Start Time for Picker
        var calendar:NSCalendar = NSCalendar.currentCalendar()
        var date = startPicker.date
        var components = calendar.components([.Hour], fromDate: date)
        components.hour = shift.timeStart.hour
        components.minute = shift.timeStart.minutes
        startPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
     
        // Sets End Time for Picker
        calendar = NSCalendar.currentCalendar()
        date = endPicker.date
        components = calendar.components([.Hour], fromDate: date)
        components.hour = shift.timeEnd.hour
        components.minute = shift.timeEnd.minutes
        endPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
    }
    
    func extractContent() {
        // Get start time from date picker
        shift.day = dayPicker.selectedRowInComponent(0)
        var calendar = NSCalendar.currentCalendar()
        var date = startPicker.date
        var components = calendar.components([.Hour], fromDate: date)
        let startHour = components.hour
        components = calendar.components([.Minute], fromDate: date)
        let startMinutes = components.minute
        
        // Get end tiem from date picker
        calendar = NSCalendar.currentCalendar()
        date = endPicker.date
        components = calendar.components([.Hour], fromDate: date)
        let endHour = components.hour
        components = calendar.components([.Minute], fromDate: date)
        let endMinutes = components.minute
        
        // Set shifts new times
        shift.timeStart.hour = startHour
        shift.timeStart.minutes = startMinutes
        shift.timeEnd.hour = endHour
        shift.timeEnd.minutes = endMinutes
        
        
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
