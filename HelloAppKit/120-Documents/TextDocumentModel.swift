//
//  TextDocumentModel.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/31/24.
//

import Foundation

// Properties should be declared dynamic in Swift,
// which tells the compiler to use dynamic dispatch to access that attribute.

class TextDocumentModel: NSObject {

    @objc dynamic var content = ""

    public init(content: String) {
        self.content = content
    }

}
