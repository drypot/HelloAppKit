//
//  DocumentDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/23/24.
//

import AppKit

class DocumentDemoController: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
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
        let button1 = NSButton(title: "Open TextDocument", target: self, action: #selector(button1Clicked))
        stackView.addArrangedSubview(button1)

//        let button2 = NSButton(title: "Open JsonDocument", target: self, action: #selector(button2Clicked))
//        stackView.addArrangedSubview(button2)
//
//        let button3 = NSButton(title: "Button 3", target: self, action: #selector(button3Clicked))
//        stackView.addArrangedSubview(button3)
    }

    @objc func button1Clicked(_ sender: NSButton) {
        let sampleString = "In an age of endless noise and fleeting moments, the rarest treasures are found in the quiet places where we reconnect with ourselves."
        let document = TextDocument()
        document.content = sampleString
        document.makeWindowControllers()
        
        document.showWindows()
    }

    @objc func button2Clicked(_ sender: NSButton) {
        print("button2 clicked")
    }

    @objc func button3Clicked(_ sender: NSButton) {
        print("button3 clicked")
    }

}
