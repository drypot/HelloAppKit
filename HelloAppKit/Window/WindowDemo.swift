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
        stackView.alignment = .leading
        view.addSubview(stackView)

        addStackItems(stackView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            //stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            //stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func addStackItems(_ stackView: NSStackView) {
        do {
            let button = NSButton(title: "Open Window", target: self, action: #selector(openWindow))
            stackView.addArrangedSubview(button)
        }

        do {
            let button = NSButton(title: "Test WindowBuilder showAtCenter", target: self, action: #selector(testWindowBuilderShowAtCenter))
            stackView.addArrangedSubview(button)
        }

        do {
            let button = NSButton(title: "Test WindowBuilder showAtAbsoluteCenter", target: self, action: #selector(testWindowBuilderShowAtAbsoluteCenter))
            stackView.addArrangedSubview(button)
        }
    }

    @objc func openWindow() {
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

    @objc func testWindowBuilderShowAtCenter() {
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable, /* .miniaturizable */],
            backing: .buffered,
            defer: false
        )
        WindowBuilder(title: "WindowBuilder / Center", window: window)
            .setSize(NSSize(width: 600, height: 700))
            .showAtCenter()
            .retainWindow()
    }

    @objc func testWindowBuilderShowAtAbsoluteCenter() {
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable, /* .miniaturizable */],
            backing: .buffered,
            defer: false
        )
        WindowBuilder(title: "WindowBuilder / Absolute Center", window: window)
            .setSize(NSSize(width: 400, height: 150))
            .showAtAbsoluteCenter()
            .retainWindow()
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

