//
//  SplitViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/9/25.
//

import Cocoa

// Adopt the new look of macOS
// https://developer.apple.com/videos/play/wwdc2020/10104

// Integrating a Toolbar and Touch Bar into Your App
// https://developer.apple.com/documentation/appkit/integrating-a-toolbar-and-touch-bar-into-your-app

// https://github.com/marioaguzman/toolbar

// macOS full height sidebar window
// https://medium.com/@bancarel.paul/macos-full-height-sidebar-window-62a214309a80

class SplitViewDemo: NSViewController {

    var windowController: SplitViewDemoWindowController?

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let button1 = NSButton(title: "Open SplitView Window", target: self, action: #selector(openWindow))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    @objc func openWindow() {
        if windowController == nil {
            windowController = SplitViewDemoWindowController()
            windowController?.window?.center()
        }
        if let windowController {
            windowController.showWindow(nil)
        }
    }

}

