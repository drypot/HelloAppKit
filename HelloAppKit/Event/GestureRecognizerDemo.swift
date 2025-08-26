//
//  GestureRecognizerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class GestureRecognizerDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let customView = CustomView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

}

fileprivate class CustomView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.quaternarySystemFill.cgColor

        let gestRecog = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        addGestureRecognizer(gestRecog)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // override var isFlipped: Bool { true }

    @objc func handleClick(_ sender: NSClickGestureRecognizer) {
        let locationInView = sender.location(in: sender.view)
        print("Mouse clicked at: \(locationInView)")
    }

}
