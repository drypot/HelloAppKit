//
//  WindowBuilder.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/28/24.
//

import AppKit

struct WindowBuilder {
    
    private static var windows = [NSWindow]()
    
    let window: NSWindow

    init(title: String, window: NSWindow) {
        self.window = window
        self.window.title = title
    }
    
    init(title: String, viewController: NSViewController) {
        let window = NSWindow(contentViewController: viewController)
        self.init(title: title, window: window)
    }
    
    func setTitle(_ title: String) -> WindowBuilder {
        window.title = title
        return self
    }
    
    func setSize(_ size: NSSize) -> WindowBuilder {
        window.setContentSize(size)
        return self
    }
    
    func show() -> WindowBuilder {
        window.makeKeyAndOrderFront(nil)
        return self
    }

    func showAtCenter() -> WindowBuilder {
        window.layoutIfNeeded()
        window.center()
        return show()
    }
    
    func showAtAbsoluteCenter() -> WindowBuilder {
        window.layoutIfNeeded()
        moveWindowToAbsoluteCenter()
        return show()
    }
    
    private func moveWindowToAbsoluteCenter() {
        guard let screen = window.screen ?? NSScreen.main else { return }
                
        let screenRect = screen.visibleFrame
        let windowSize = window.frame.size
        
        let x = (screenRect.width - windowSize.width) / 2 + screenRect.origin.x
        let y = (screenRect.height - windowSize.height) / 2 + screenRect.origin.y

        window.setFrameOrigin(NSPoint(x: x, y: y))
    }
    
    func retainWindow() {
        Self.windows.append(window)
    }

}

