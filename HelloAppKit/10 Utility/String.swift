//
//  String.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 10/2/24.
//

import Foundation

extension String {
    func dropSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }
}
