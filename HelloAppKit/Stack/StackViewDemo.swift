//
//  StackViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/23/24.
//

import AppKit

class StackViewDemoController: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.wantsLayer = true
        stackView.layer?.backgroundColor = CGColor.gray9
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
        do {
            let stackView2 = NSStackView()
            stackView2.translatesAutoresizingMaskIntoConstraints = false
            stackView2.orientation = .vertical
            stackView2.wantsLayer = true
            stackView2.layer?.backgroundColor = CGColor.gray8

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
            stackView2.wantsLayer = true
            stackView2.layer?.backgroundColor = CGColor.gray8

            let button4 = NSButton(title: "Button 4", target: nil, action: nil)
            stackView2.addArrangedSubview(button4)

            let button5 = NSButton(title: "Button 5", target: nil, action: nil)
            stackView2.addArrangedSubview(button5)

            let button6 = NSButton(title: "Button 6", target: nil, action: nil)
            stackView2.addArrangedSubview(button6)

            stackView.addArrangedSubview(stackView2)
        }
    }

}
