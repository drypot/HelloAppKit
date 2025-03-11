//
//  SheetWindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class PresentAsSheetDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let button1 = NSButton(title: "Open sheet", target: self, action: #selector(openSheet))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    @objc func openSheet(_ sender: Any) {
        let sheetVC = SheetViewController()
        self.presentAsSheet(sheetVC)
    }

    class SheetViewController: NSViewController {
        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false

            let helloLabel = NSTextField(labelWithString: "Hello")
            helloLabel.translatesAutoresizingMaskIntoConstraints = false
            helloLabel.font = NSFont.systemFont(ofSize: 18, weight: .medium)
            helloLabel.alignment = .center
            view.addSubview(helloLabel)

            let closeButton = NSButton(title: "Close", target: self, action: #selector(closeSheet(_:)))
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.controlSize = .large
            view.addSubview(closeButton)

            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),

                helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            ])
        }

        @objc func closeSheet(_ sender: Any) {
            self.dismiss(self)
        }
    }

}
