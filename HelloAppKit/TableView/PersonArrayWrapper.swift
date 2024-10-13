//
//  PersonArrayWrapper.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/16/24.
//

import Foundation

class PersonArrayWrapper: NSObject {
    
    @objc dynamic var content: [Person]
    
    init(content: [Person]) {
        self.content = content
    }
    
    var count: Int {
        return content.count
    }
    
    func add(person: Person) {
        content.append(person)
    }
    
}
