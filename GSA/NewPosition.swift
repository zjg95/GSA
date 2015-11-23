
//
//  NewPosition.swift
//  GSA
//
//  Created by Andrew Capindo on 11/22/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import UIKit

class NewPosition: UIViewController {
    
    // ------------
    // Data Members
    // ------------
    
    var positions:[Position] = []
    
    @IBOutlet weak var oldPositions: UIPickerView!
    
    @IBOutlet weak var newPosition: UITextField!
    
    @IBOutlet weak var level: UISlider!
    
    @IBAction func addPosition(sender: AnyObject) {
        Position position = Position(title: newPosition.text!, UISlider.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        oldPositions.dataSource = self
//        oldPositions.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return positions.count
//    }
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return positions[row].title
//    }
}
