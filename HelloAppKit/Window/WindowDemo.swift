//
//  WindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/18/24.
//

import AppKit

class WindowDemo: NSViewController {

    var window: NSWindow?
    var windowAtAbsoluteCenter: NSWindow?

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let button1 = NSButton(title: "Open window", target: self, action: #selector(openWindow))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        let button2 = NSButton(title: "Open window at absolute center", target: self, action: #selector(openWindowAtAbsoluteCenter))
        button2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button2)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 8),
            button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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

        let contentView = NSView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        window.contentView = contentView

        let label = NSTextField(labelWithString: "Window close demo")
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = NSFont.systemFont(ofSize: 24.0)
        label.sizeToFit()
        contentView.addSubview(label)
        
        let closeButton = NSButton(title: "Close", target: self, action: #selector(closeAction))
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.keyEquivalent = "\r"
        contentView.addSubview(closeButton)

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            closeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])

        window.center()
        window.makeKeyAndOrderFront(nil)
    }

    @objc func closeAction(_ sender: NSButton) {
        window!.close()
    }

    @objc func openWindowAtAbsoluteCenter() {
        if windowAtAbsoluteCenter == nil {
            windowAtAbsoluteCenter = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }

        let window = windowAtAbsoluteCenter!
        
        window.title = "Window at Absolute Center"
        window.isReleasedWhenClosed = false // 이거 안 하고 윈도우 닫았다가 다시 Open 버튼 누르면 크래쉬난다.
        window.contentViewController = NSViewController()
        moveWindowToAbsoluteCenter(window)

        window.makeKeyAndOrderFront(nil)
    }

    private func moveWindowToAbsoluteCenter(_ window: NSWindow) {
        guard let screen = window.screen ?? NSScreen.main else { return }

        let screenRect = screen.visibleFrame
        let windowSize = window.frame.size

        let x = (screenRect.width - windowSize.width) / 2 + screenRect.origin.x
        let y = (screenRect.height - windowSize.height) / 2 + screenRect.origin.y

        window.setFrameOrigin(NSPoint(x: x, y: y))
    }
}



