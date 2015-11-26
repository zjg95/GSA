//
//  EditPositionController.swift
//  GSA
//
//  Created by Andrew Capindo on 11/24/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class EditPositionController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ------------
    // Data Members
    // ------------
    
    var position:Position!
    var index:NSIndexPath!
    
    @IBOutlet weak var titles: UIPickerView!
    
    @IBOutlet weak var level: UISegmentedControl!
    
    @IBOutlet weak var saveChanges: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titles.dataSource = self
        titles.delegate = self
        
        level.selectedSegmentIndex = position!.level        
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
        return selections.selections.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selections.selections[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
            position.title = selections.selections[titles.selectedRowInComponent(0)]
            position.level = level.selectedSegmentIndex
    }
    
}
