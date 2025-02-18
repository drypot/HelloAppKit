//
//  SheetWindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class SheetWindowDemo: NSViewController {

    let stackView = NSStackView()
    var sheetWindow: NSWindow? = nil

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
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        do {
            let button = NSButton(title: "Open sheet", target: self, action: #selector(openSheet))
            stackView.addArrangedSubview(button)
        }
    }

    @objc func openSheet() {
        if sheetWindow == nil {
            sheetWindow = SheetWindow()
        }

        guard let window = self.view.window else {
            fatalError()
        }
        guard let sheetWindow else {
            fatalError()
        }

        window.beginSheet(sheetWindow) { response in
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
