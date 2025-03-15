//
//  WindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/18/24.
//

import AppKit

class DemoTemplate: NSViewController {

    var window: NSWindow?

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let button1 = NSButton(title: "Open window", target: self, action: #selector(openWindow))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        let button2 = NSButton(title: "Open window 2", target: self, action: #selector(openWindow))
        button2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button2)

        let button3 = NSButton(title: "Open window 3", target: self, action: #selector(openWindow))
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

        guard let window else { fatalError() }

        window.title = "Window Demo"
        window.isReleasedWhenClosed = false // 윈도우 닫았다가 다시 Open 할 때 크래쉬를 방지.

        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])

        window.contentView = view

        window.center()
        window.makeKeyAndOrderFront(nil)
    }

}



