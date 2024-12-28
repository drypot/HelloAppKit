//
//  Subclasses.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 10/2/24.
//

import Foundation

// https://stackoverflow.com/questions/42746981/list-all-subclasses-of-one-class

class SubclassesTestRunner: SubRunner {
    override func run() {
        let seconds = interval {
            subclasses(of: SubRunner.self).forEach { print($0.className()) }
        }
        print("\(seconds) seconds")
    }
}

public func subclasses<T>(of theClass: T) -> [T] {
    var count: UInt32 = 0
    var result: [T] = []
    
    let classList = objc_copyClassList(&count)!
    defer { free(UnsafeMutableRawPointer(classList)) }
    
    let classes = UnsafeBufferPointer(start: classList, count: Int(count))
    let classPtr = address(of: theClass)

    for someClass in classes {
        guard let someSuperClass = class_getSuperclass(someClass), address(of: someSuperClass) == classPtr else { continue }
        result.append(someClass as! T)
    }

    return result
}

public func address(of object: Any?) -> UnsafeMutableRawPointer {
    return Unmanaged.passUnretained(object as AnyObject).toOpaque()
}
