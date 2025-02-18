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
        view.translatesAutoresizingMaskIntoConstraints = false

        let button1 = NSButton(title: "Open sheet", target: self, action: #selector(openSheet))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
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

            let contentView = NSView()
            contentView.translatesAutoresizingMaskIntoConstraints = false

            self.contentView = contentView

            let textField = NSTextField(labelWithString: "Sheet Window Demo")
            textField.translatesAutoresizingMaskIntoConstraints = false
//            textField.font = NSFont.systemFont(ofSize: 24.0)
            textField.sizeToFit()
            contentView.addSubview(textField)

            let cancelButton = NSButton(title: "Cancel", target: self, action: #selector(cancelAction))
            cancelButton.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(cancelButton)

            let okButton = NSButton(title: "OK", target: self, action: #selector(okAction))
            okButton.translatesAutoresizingMaskIntoConstraints = false
            okButton.bezelStyle = .rounded
            okButton.keyEquivalent = "\r"
            contentView.addSubview(okButton)

            NSLayoutConstraint.activate([
                contentView.widthAnchor.constraint(equalToConstant: 400),
                contentView.heightAnchor.constraint(equalToConstant: 200),

                textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),

                okButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                okButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

                cancelButton.trailingAnchor.constraint(equalTo: okButton.leadingAnchor, constant: -8),
                cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
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
