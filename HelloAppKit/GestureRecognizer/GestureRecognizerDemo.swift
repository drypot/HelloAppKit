//
//  GestureRecognizerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class GestureRecognizerDemoRunner: SubRunner {
}

class GestureRecognizerDemoController: EasyStackController {
    
    override func addSubviews(to stackView: NSStackView) {
        let childView1 = NSView()
        childView1.wantsLayer = true
        childView1.layer?.backgroundColor = NSColor.red.cgColor
        stackView.addArrangedSubview(childView1)
        
        NSLayoutConstraint.activate([
            childView1.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            childView1.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
        ])
        
        let clickGestureRecognizer = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        childView1.addGestureRecognizer(clickGestureRecognizer)
    }

    @objc func handleClick(_ sender: NSClickGestureRecognizer) {
        let locationInView = sender.location(in: sender.view)
        print("Mouse clicked at: \(locationInView)")
    }

}
