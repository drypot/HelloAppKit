//
//  TextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import AppKit

class TextViewDemoController: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        view.addSubview(stackView)

        addStackItems(stackView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func addStackItems(_ stackView: NSStackView) {
        let textView = NSTextView()
        textView.string = "Hello, World!"
        textView.font = NSFont(name: "Helvetica", size: 24.0)
        stackView.addArrangedSubview(textView)

        NSLayoutConstraint.activate([
            textView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400)
        ])
    }
}
