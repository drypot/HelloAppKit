//
//  WindowControllerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class WindowControllerDemo: NSViewController {

    let windowController = CustomWindowController()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let button1 = NSButton(title: "Open window", target: self, action: #selector(openWindow))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
    }

    @objc func openWindow() {
        windowController.window?.center()
        windowController.showWindow(nil)
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
