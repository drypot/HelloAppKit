//
//  ViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class ViewDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let child = NSView()
        child.translatesAutoresizingMaskIntoConstraints = false
        child.wantsLayer = true
        child.layer?.backgroundColor = NSColor.red.cgColor
        view.addSubview(child)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            child.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            child.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            child.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            child.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

}
