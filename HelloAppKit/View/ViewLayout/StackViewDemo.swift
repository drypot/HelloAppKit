//
//  StackViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/23/24.
//

import AppKit

class StackViewDemo: NSViewController {

    override func loadView() {
        view = NSView()

        // Setup StackView

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])

        // Setup StackItems

        do {
            let text = NSTextField(labelWithString: "Text 1")
            stackView.addArrangedSubview(text)
        }

        do {
            let text = NSTextField(labelWithString: "Text 2")
            stackView.addArrangedSubview(text)
        }

        do {
            let text = NSTextField(labelWithString: "Text 3")
            stackView.addArrangedSubview(text)
        }
    }

}
