//
//  GestureRecognizerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class GestureRecognizerDemo: NSViewController {

    override func loadView() {
        view = NSView()

        let childView = NSView()
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.wantsLayer = true
        childView.layer?.backgroundColor = NSColor.green.cgColor
        view.addSubview(childView)

        let clickGestureRecognizer = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        childView.addGestureRecognizer(clickGestureRecognizer)

        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            childView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            childView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    @objc func handleClick(_ sender: NSClickGestureRecognizer) {
        let locationInView = sender.location(in: sender.view)
        print("Mouse clicked at: \(locationInView)")
    }

}
