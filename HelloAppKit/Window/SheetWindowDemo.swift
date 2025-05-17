//
//  SheetWindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class SheetWindowDemo: NSViewController {

    var sheetWindow = SheetWindow()

    override func loadView() {
        view = NSView()

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

    @objc func openSheet() {
        self.view.window?.beginSheet(sheetWindow) { response in
            switch response {
            case .OK:
                print("sheet response: ok")
            case .cancel:
                print("sheet response: cancel")
            default:
                print("sheet response: etc")
            }
        }
    }

    class SheetWindow: NSWindow {
        init() {
            super.init(
                contentRect: .zero,
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )

            self.isReleasedWhenClosed = false

            let view = NSView()

            self.contentView = view

            let textField = NSTextField(labelWithString: "Sheet Window Demo")
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = .systemFont(ofSize: 18, weight: .medium)
//            textField.sizeToFit()
            view.addSubview(textField)

            let cancelButton = NSButton(title: "Cancel", target: self, action: #selector(cancelAction))
            cancelButton.translatesAutoresizingMaskIntoConstraints = false
            cancelButton.controlSize = .large
            view.addSubview(cancelButton)

            let okButton = NSButton(title: "OK", target: self, action: #selector(okAction))
            okButton.translatesAutoresizingMaskIntoConstraints = false
            okButton.controlSize = .large
            okButton.keyEquivalent = "\r"
            view.addSubview(okButton)

            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 400),
                view.heightAnchor.constraint(equalToConstant: 200),

                textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
                textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                cancelButton.trailingAnchor.constraint(equalTo: okButton.leadingAnchor, constant: -10),
                cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),

                okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
                okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
        }

        @objc private func cancelAction(_ sender: NSButton) {
            self.sheetParent?.endSheet(self, returnCode: .cancel)
        }

        @objc private func okAction(_ sender: NSButton) {
            self.sheetParent?.endSheet(self, returnCode: .OK)
        }
    }

}
