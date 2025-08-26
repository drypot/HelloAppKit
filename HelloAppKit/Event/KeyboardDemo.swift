//
//  KeyboardDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/26/25.
//

import AppKit

class KeyboardDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let customView = CustomView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)

        let customView2 = CustomView()
        customView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView2)

        NSLayoutConstraint.activate([
            customView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
            customView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),

            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),

            customView2.widthAnchor.constraint(equalTo: customView.widthAnchor),
            customView2.heightAnchor.constraint(equalTo: customView.heightAnchor),
            customView2.topAnchor.constraint(equalTo: customView.topAnchor),
            customView2.leadingAnchor.constraint(equalTo: customView.trailingAnchor, constant: 20),
            customView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
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

    override var acceptsFirstResponder: Bool {
        return true
    }

    override func keyDown(with event: NSEvent) {
        let modiString = makeModiString(from: event)

        print("""
            ---
            keyDown,
            characters: \(event.characters!),
            keyCode: \(event.keyCode),
            isARepeat: \(event.isARepeat),
            modifiers: \(modiString)
            """
        )

        interpretKeyEvents([event])
    }

    override func keyUp(with event: NSEvent) {
        let modiString = makeModiString(from: event)

        print("""
            ---
            keyUp,
            characters: \(event.characters!),
            keyCode: \(event.keyCode),
            isARepeat: \(event.isARepeat),
            modifiers: \(modiString)
            """
        )
    }

    override func flagsChanged(with event: NSEvent) {
        let modiString = makeModiString(from: event)

        print("""
            ---
            flagsChanged,
            modifiers: \(modiString)
            """
        )
    }

    override func insertText(_ insertString: Any) {
        let text = insertString as! String
        print("""
            ---
            insertText,
            text: \(text)
            """
        )
    }

    override func insertTab(_ sender: Any?) {
        window?.selectNextKeyView(sender)
    }

    override func insertBacktab(_ sender: Any?) {
        window?.selectPreviousKeyView(sender)
    }

    private func makeModiString(from event: NSEvent) -> String {
        let modifierFlags = event.modifierFlags
        var modiArray = [String]()
        if modifierFlags.contains(.control) { modiArray.append("Ctrl") }  // ⌃ : Up Arrowhead
        if modifierFlags.contains(.option)  { modiArray.append("Opt") }   // ⌥ : Option
        if modifierFlags.contains(.shift)   { modiArray.append("Shift") } // ⇧ : Upwards white arrow
        if modifierFlags.contains(.command) { modiArray.append("Cmd") }   // ⌘ : Place of interest sign
        return modiArray.joined(separator: " ")
    }

    override func drawFocusRingMask() {
        NSBezierPath.fill(bounds)
    }

    override var focusRingMaskBounds: NSRect {
        return bounds
    }

}
