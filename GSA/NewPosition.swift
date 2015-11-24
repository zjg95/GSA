
//
//  NewPosition.swift
//  GSA
//
//  Created by Andrew Capindo on 11/22/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class NewPosition: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ------------
    // Data Members
    // ------------
    
    var position:Position!
    var selection:[String] = selections.selections
    
    @IBOutlet weak var level: UISlider!
    
    @IBOutlet weak var newTitle: UIPickerView!
    
    @IBAction func addPosition(sender: AnyObject) {
        let x = newTitle.selectedRowInComponent(0)
        let newPosition = Position(title: selection[x], level: level.value)
        position! = newPosition
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newTitle.dataSource = self
        newTitle.delegate = self
        
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
        return selection.count
    }
    
    //MARK: Delegates
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selection[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let x = newTitle.selectedRowInComponent(0)
        let newPosition = Position(title: selection[x], level: level.value)
        if position != nil {
            position! = newPosition
        }
        else {
            position = newPosition
        }
    }
}
