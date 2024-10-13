//
//  WindowBuilderDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/18/24.
//

import AppKit

class WindowBuilderDemoRunner: SubRunner {
    
    override func run() {
        do {
            // show center
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
        
        do {
            // show absolute center
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
        
        do {
            // with ViewController
            WindowBuilder(
                title: "WindowBuilder / with ViewController",
                viewController: NSViewController()
            )
            .setSize(NSSize(width: 700, height: 200))
            .showAtCenter()
            .retainWindow()
        }
    }
    
}
