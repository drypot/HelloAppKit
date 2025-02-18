//
//  WindowControllerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class WindowControllerDemo: NSViewController {

    let padding = 20.0
    let stackView = NSStackView()

    let windowController1 = CustomWindowController()

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
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        do {
            let button = NSButton(title: "Open window by NSWindowController", target: self, action: #selector(openWindow))
            stackView.addArrangedSubview(button)
        }
    }

    @objc func openWindow() {
        windowController1.window?.center()
        windowController1.showWindow(nil)
    }

    class CustomWindowController: NSWindowController, NSWindowDelegate {

        init() {
            // window 는 windowController 가 retain 하므로 따로 retain 하지 않아도 된다.
            let window = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )

            super.init(window: window)

            window.title = "WindowController Demo"
            window.contentViewController = NSViewController()
            window.delegate = self
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // NSWindowDelegate methods

        func windowWillClose(_ notification: Notification) {
            print("CustomWindowController: window will close")
        }
    }

}
