//
//  ViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class ViewDemoRunner: SubRunner {
}

class ViewDemoController: EasyStackController {
        
    override func addStckItems(_ stackView: NSStackView) {
        stackView.distribution = .fillEqually

        let childView = NSView()
        childView.wantsLayer = true
        childView.layer?.backgroundColor = NSColor.red.cgColor
        stackView.addArrangedSubview(childView)

        NSLayoutConstraint.activate([
            childView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
        ])
    }
    
}
