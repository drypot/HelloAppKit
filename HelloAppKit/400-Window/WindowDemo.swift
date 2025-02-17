//
//  WindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/18/24.
//

import AppKit

class WindowDemo: NSViewController {

    let padding = 20.0
    let stackView = NSStackView()

    var window1: NSWindow?
    var window2: NSWindow?

    let button = NSButton()

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
            let button = NSButton(title: "Open window at center", target: self, action: #selector(openWindow))
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Open window at absolute center", target: self, action: #selector(openWindowAtAbsoluteCenter))
            stackView.addArrangedSubview(button)
        }
    }

    @objc func openWindow() {
        if window1 == nil {
            window1 = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }
        window1!.title = "Window Demo / Center"
        window1!.isReleasedWhenClosed = false // 이거 안 하고 윈도우 닫았다가 다시 Open 버튼 누르면 크래쉬난다.
        window1!.contentViewController = NSViewController()
        window1!.center()
        window1!.makeKeyAndOrderFront(nil)
    }

    @objc func openWindowAtAbsoluteCenter() {
        if window2 == nil {
            window2 = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }
        window2!.title = "Window Demo / Absolute Center"
        window2!.isReleasedWhenClosed = false // 이거 안 하고 윈도우 닫았다가 다시 Open 버튼 누르면 크래쉬난다.
        window2!.contentViewController = NSViewController()
        moveWindowToAbsoluteCenter(window2!)
        window2!.makeKeyAndOrderFront(nil)
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



