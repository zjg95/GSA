//
//  AddPositionController.swift
//  GSA
//
//  Created by Andrew Capindo on 11/24/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class AddPositionController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ------------
    // Data Members
    // ------------
    
    var positions:[Position]!
    
    @IBOutlet weak var titles: UIPickerView!
    
    @IBOutlet weak var level: UISlider!
    
    @IBAction func addPosition(sender: AnyObject) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
}
