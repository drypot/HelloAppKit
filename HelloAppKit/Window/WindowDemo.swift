//
//  WindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/18/24.
//

import AppKit

class WindowDemoRunner: SubRunner {

    override func run() {
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable, /* .miniaturizable */],
            backing: .buffered,
            defer: false
        )
        window.title = "Window 1"
        
        let windowController = WindowDemoWindowController(window: window)
        windowController.contentViewController = NSViewController()
        windowController.window?.center()
        windowController.showWindow(nil)
    }
}

class WindowDemoWindowController: NSWindowController, NSWindowDelegate {
    
    private var selfRetainer: WindowDemoWindowController?
    
    override init(window: NSWindow?) {
        super.init(window: window)
        self.selfRetainer = self
        self.window?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func windowWillClose(_ notification: Notification) {
        print("WindowDelegate windowWillClose")
        selfRetainer = nil
    }

}
