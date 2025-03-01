//
//  AppDelegate.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/27/24.
//

import Cocoa

@MainActor @main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationWillFinishLaunching(_ notification: Notification) {
        print("ApplicationWillFinishLaunching")
#if DEV
        print("Compiler flag DEV defined")
#else
        print("Compiler flag DEV not defined")
#endif
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("ApplicationDidFinishLaunching")
        setupWindow()
    }

    func setupWindow() {
        window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )

        window.title = "AppKit Demo"
        window.contentViewController = NavigatorController()
        window.setFrameAutosaveName("MainWindowFrame")
        window.layoutIfNeeded()
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        print("ApplicationWillTerminate")
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        return false
    }

}
