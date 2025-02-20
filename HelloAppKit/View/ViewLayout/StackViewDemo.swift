//
//  StackViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/23/24.
//

import AppKit

class StackViewDemo: NSViewController {

    let stackView = NSStackView()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupStackView()
        setupStackItems()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    func setupStackItems() {
        let button1 = NSButton(title: "Button 1", target: self, action: #selector(buttonAction))
        stackView.addArrangedSubview(button1)

        let button2 = NSButton(title: "Button 2", target: self, action: #selector(buttonAction))
        stackView.addArrangedSubview(button2)

        let button3 = NSButton(title: "Button 3", target: self, action: #selector(buttonAction))
        stackView.addArrangedSubview(button3)
    }

    @objc func buttonAction(_ sender: NSButton) {
        print("button clicked")
    }

}
