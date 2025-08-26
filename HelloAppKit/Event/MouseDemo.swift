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
        let location = convert(event.locationInWindow, from: nil) // 로컬 좌표

        let modifierFlags = event.modifierFlags
        var modiArray = [String]()
        if modifierFlags.contains(.control) { modiArray.append("Ctrl") }  // ⌃ : Up Arrowhead
        if modifierFlags.contains(.option)  { modiArray.append("Opt") }   // ⌥ : Option
        if modifierFlags.contains(.shift)   { modiArray.append("Shift") } // ⇧ : Upwards white arrow
        if modifierFlags.contains(.command) { modiArray.append("Cmd") }   // ⌘ : Place of interest sign
        let modiString = modiArray.joined(separator: " ")

        print("""
            ---
            \(eventName), 
            x: \(location.x), y: \(location.y), 
            button: \(event.buttonNumber),
            clickCount: \(event.clickCount)
            modifiers: \(modiString)
            """
        )
    }

}
