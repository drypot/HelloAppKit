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
        
    override func addSubviews(to stackView: NSStackView) {
        stackView.distribution = .fillEqually
        do {
            let customView = CustomView(frame: .zero, color: .green)
            stackView.addArrangedSubview(customView)
            
            NSLayoutConstraint.activate([
                customView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            ])
        }
        
        do {
            let customView = CustomCompositeView()
            stackView.addArrangedSubview(customView)

            NSLayoutConstraint.activate([
                customView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            ])
        }
        
        do {
            let childView = NSView()
            childView.wantsLayer = true
            childView.layer?.backgroundColor = NSColor.red.cgColor
            stackView.addArrangedSubview(childView)
            
            NSLayoutConstraint.activate([
                childView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            ])
        }
    }
    
}
