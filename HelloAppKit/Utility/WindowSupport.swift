//
//  WindowSupport.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/15/25.
//

import AppKit

struct WindowSupport {

    @MainActor
    static func moveWindowToAbsoluteCenter(_ window: NSWindow) {
        guard let screen = window.screen ?? NSScreen.main else { return }

        let screenRect = screen.visibleFrame
        let windowSize = window.frame.size

        let x = (screenRect.width - windowSize.width) / 2 + screenRect.origin.x
        let y = (screenRect.height - windowSize.height) / 2 + screenRect.origin.y

        window.setFrameOrigin(NSPoint(x: x, y: y))
    }

}
