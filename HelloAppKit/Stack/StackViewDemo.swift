//
//  StackViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/23/24.
//

import AppKit

class StackViewDemoRunner: SubRunner {
}

class StackViewDemoController: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        view.addSubview(stackView)

        do {
            let stackView2 = NSStackView()
            stackView2.translatesAutoresizingMaskIntoConstraints = false
            stackView2.orientation = .vertical

            let button1 = NSButton(title: "Button 1", target: nil, action: nil)
            stackView2.addArrangedSubview(button1)

            let button2 = NSButton(title: "Button 2", target: nil, action: nil)
            stackView2.addArrangedSubview(button2)

            let button3 = NSButton(title: "Button 3", target: nil, action: nil)
            stackView2.addArrangedSubview(button3)

            stackView.addArrangedSubview(stackView2)
        }

        do {
            let stackView2 = NSStackView()
            stackView2.translatesAutoresizingMaskIntoConstraints = false
            stackView2.orientation = .horizontal

            let button4 = NSButton(title: "Button 4", target: nil, action: nil)
            stackView2.addArrangedSubview(button4)

            let button5 = NSButton(title: "Button 5", target: nil, action: nil)
            stackView2.addArrangedSubview(button5)

            let button6 = NSButton(title: "Button 6", target: nil, action: nil)
            stackView2.addArrangedSubview(button6)

            stackView.addArrangedSubview(stackView2)
        }

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
}
