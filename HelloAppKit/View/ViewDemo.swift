//
//  ViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class ViewDemoRunner: SubRunner {
}

class ViewDemoController: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        let childView = NSView()
        childView.wantsLayer = true
        childView.layer?.backgroundColor = NSColor.red.cgColor
        stackView.addArrangedSubview(childView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            childView.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            childView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
        ])
    }

}
