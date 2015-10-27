//
//  CopyProtocol.swift
//  GSA
//
//  Created by Zach Goodman on 10/26/15.
//  Copyright © 2015 Zach Goodman. All rights reserved.
//

import Foundation

protocol CopyProtocol {
    init(original: Self)
}

extension CopyProtocol {
    func copy() -> Self {
        return Self.init(original: self)
    }
}