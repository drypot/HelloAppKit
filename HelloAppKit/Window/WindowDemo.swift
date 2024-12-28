//
//  WindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/18/24.
//

import AppKit

class WindowDemoController: NSViewController {

    let button = NSButton()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        view.addSubview(stackView)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Open Window"
        button.target = self
        button.action = #selector(buttonClicked)
        stackView.addArrangedSubview(button)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        ])
    }

    @objc func buttonClicked() {
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable, /* .miniaturizable */],
            backing: .buffered,
            defer: false
        )
        window.title = "Window 1"

        let windowController = DemoWindowController(window: window)
        windowController.contentViewController = NSViewController()
        windowController.window?.center()
        windowController.showWindow(nil)
    }
}

class DemoWindowController: NSWindowController, NSWindowDelegate {
    
    private var selfRetainer: DemoWindowController?
    
    override init(window: NSWindow?) {
        super.init(window: window)
        self.selfRetainer = self
        self.window?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func windowWillClose(_ notification: Notification) {
        print("windowWillClose")
        selfRetainer = nil
    }

}

