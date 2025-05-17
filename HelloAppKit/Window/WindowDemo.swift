//
//  WindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/18/24.
//

import AppKit

class WindowDemo: NSViewController {

    var window: NSWindow?
    var window2: NSWindow?
    var windowController: NSWindowController?

    override func loadView() {
        view = NSView()

        let button1 = NSButton(title: "Open window", target: self, action: #selector(openWindow))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        let button2 = NSButton(title: "Open window with ViewController", target: self, action: #selector(openWindow2))
        button2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button2)

        let button3 = NSButton(title: "Open window with WindowController", target: self, action: #selector(openWindow3))
        button3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button3)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 8),
            button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 8),
            button3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    @objc func openWindow() {
        if window == nil {
            window = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }

        let window = self.window!

        window.title = "Demo"
        window.isReleasedWhenClosed = false // 윈도우 닫았다가 다시 Open 할 때 크래쉬를 방지.

        let view = NSView()
        window.contentView = view

        let label = NSTextField(labelWithString: "Window Demo")
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        window.center()
        window.makeKeyAndOrderFront(nil)
    }

    @objc func openWindow2() {
        if window == nil {
            window = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }

        let window = self.window!

        window.title = "Demo2"
        window.isReleasedWhenClosed = false // 윈도우 닫았다가 다시 Open 할 때 크래쉬를 방지.

        window.contentViewController = ViewController()
        window.center()
        window.makeKeyAndOrderFront(nil)
    }

    class ViewController: NSViewController {
        override func loadView() {
            view = NSView()

            let child = NSView()
            child.translatesAutoresizingMaskIntoConstraints = false
            child.wantsLayer = true
            child.layer?.backgroundColor = NSColor.systemTeal.cgColor
            view.addSubview(child)

            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

                child.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                child.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                child.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                child.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            ])
        }
    }

    @objc func openWindow3() {
        if windowController == nil {
            windowController = WindowController()
            windowController!.window!.center()
        }

        let windowController = self.windowController!

        windowController.showWindow(nil)
    }

    class WindowController: NSWindowController, NSWindowDelegate {

        init() {
            // window 는 windowController 가 retain 하므로 따로 retain 하지 않아도 된다.
            let window = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )

            super.init(window: window)

            window.title = "Demo3"
            window.contentViewController = NSViewController()
            window.delegate = self
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // NSWindowDelegate methods

        func windowWillClose(_ notification: Notification) {
            print("window will close")
        }
    }

}
