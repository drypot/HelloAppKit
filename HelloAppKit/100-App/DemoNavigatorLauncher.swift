//
//  DemoNavigatorLauncher.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/22/24.
//

import AppKit

@MainActor
struct DemoNavigatorLauncher {

    private static var window: NSWindow!

    func run() {
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        Self.window = window

        window.title = "AppKit Demo"
        window.contentViewController = DemoNavigatorController()
        window.layoutIfNeeded()
        window.center()
        window.makeKeyAndOrderFront(nil)
    }

}
