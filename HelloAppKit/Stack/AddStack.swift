//
//  Stacker.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/23/24.
//

import AppKit

func addStackView(to parentView: NSView, addSubviews: (NSStackView) -> Void) {
    let stackView = NSStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    if let parentStackView = parentView as? NSStackView {
        parentStackView.addArrangedSubview(stackView)
    } else {
        parentView.addSubview(stackView)
    }
    addSubviews(stackView)
}
