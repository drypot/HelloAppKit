//
//  ConstrantDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class ConstrantDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let button1 = NSButton(title: "Button 1", target: self, action: #selector(buttonAction))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        let button2 = NSButton(title: "Button 2", target: self, action: #selector(buttonAction))
        button2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button2)

        let button3 = NSButton(title: "Button 3", target: self, action: #selector(buttonAction))
        button3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button3)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 8),
            button2.leadingAnchor.constraint(equalTo: button1.leadingAnchor),

            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 8),
            button3.leadingAnchor.constraint(equalTo: button2.leadingAnchor),
        ])
    }

    @objc func buttonAction(_ sender: NSButton) {
        print("button clicked")
    }

}
