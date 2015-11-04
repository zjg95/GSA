//
//  Position.swift
//  GSA
//
//  Created by Andrew Capindo on 11/3/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

class Position {
    
    // ------------
    // data members
    // ------------

    var _title: String = "";
    var _level: Int = 0;
    
    // -----------
    // constructor
    // -----------
    
    init(title: String, level: Int) {
        _title = title;
        _level = level;
    }
}

func ==(lhs: Position, rhs: Position) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}