//
//  SubRunnerSample1.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class SubRunnerSample1Runner: SubRunner {
}

class SubRunnerSample1Controller: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let childView = NSView()
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.wantsLayer = true
        childView.layer?.backgroundColor = NSColor.red.cgColor
        view.addSubview(childView)
        
        let padding = 20.0
        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            childView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            childView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            childView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

}
