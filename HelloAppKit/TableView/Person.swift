//
//  Person.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/16/24.
//

import AppKit

class Person: NSObject {
    
    dynamic var name: String
    dynamic var busy: Bool
    dynamic var shirtColor: NSColor
    
    init(name: String, busy:Bool, shirtColor: NSColor) {
        self.name = name
        self.busy = busy
        self.shirtColor = shirtColor
        super.init()
    }
    
}
