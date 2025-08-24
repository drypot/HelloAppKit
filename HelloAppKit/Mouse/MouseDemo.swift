//
//  MouseDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/25/25.
//

import AppKit

class MouseDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let customView = CustomView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

}

fileprivate class CustomView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.quaternarySystemFill.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // override var isFlipped: Bool { true }

    override func mouseDown(with event: NSEvent) {
        log(eventName: "mouseDown", event: event)
    }

    override func rightMouseDown(with event: NSEvent) {
        log(eventName: "rightMouseDown", event: event)
    }

    override func mouseDragged(with event: NSEvent) {
        log(eventName: "mouseDragged", event: event)
    }

    override func mouseUp(with event: NSEvent) {
        log(eventName: "mouseUp", event: event)
    }

    override func rightMouseUp(with event: NSEvent) {
        log(eventName: "rightMouseUp", event: event)
    }

    private func log(eventName: String, event: NSEvent) {
        let p = convert(event.locationInWindow, from: nil) // 로컬 좌표
        let mods = format(modifierFlags: event.modifierFlags)
        let btn  = event.buttonNumber // 0=좌클릭, 1=우클릭 등
        print("[\(eventName)] x=\(Int(p.x)) y=\(Int(p.y)) button=\(btn) mods=\(mods)")
    }

    private func format(modifierFlags: NSEvent.ModifierFlags) -> String {
        var s = ""
        if modifierFlags.contains(.command) { s += "⌘" }
        if modifierFlags.contains(.option)  { s += "⌥" }
        if modifierFlags.contains(.control) { s += "⌃" }
        if modifierFlags.contains(.shift)   { s += "⇧" }
        return s.isEmpty ? "" : s
    }
}
