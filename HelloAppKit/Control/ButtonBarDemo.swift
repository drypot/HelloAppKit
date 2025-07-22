//
//  ButtonBarDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/24/25.
//

import Cocoa

class ButtonBarDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let buttonBar = NSStackView()
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.orientation = .horizontal
//        buttonBar.alignment = .leading
        view.addSubview(buttonBar)

        let content = NSView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.wantsLayer = true
        content.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        view.addSubview(content)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            buttonBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            buttonBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            content.topAnchor.constraint(equalTo: buttonBar.bottomAnchor, constant: 20),
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            content.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])

        do {
            let button = NSButton(title: "Button1", target: self, action: #selector(buttonAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Button2", target: self, action: #selector(buttonAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Button3", target: self, action: #selector(buttonAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }
    }

    @objc func buttonAction(_ sender: NSButton) {
        print("button: \(sender.title)")
    }

}
