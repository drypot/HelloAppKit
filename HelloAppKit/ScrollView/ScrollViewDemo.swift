//
//  ScrollViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/22/25.
//

import Cocoa

// NSScrollView
// https://developer.apple.com/documentation/appkit/nsscrollview

// Working with Scroll Views
// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html#//apple_ref/doc/uid/TP40010853-CH24-SW1

class ScrollViewDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let documentView = CustomView()

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.documentView = documentView
        scrollView.drawsBackground = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

}

fileprivate class CustomView: NSView {

    private let count = 128
    private let fieldWidth: CGFloat = 200
    private let rowHeight: CGFloat = 24
    private let sidePadding: CGFloat = 12
    private let topBottomPadding: CGFloat = 12

    override init(frame frameRect: NSRect) {
        let width = sidePadding * 2 + fieldWidth
        let height = topBottomPadding * 2 + CGFloat(count) * rowHeight
        super.init(frame: NSRect(x: 0, y: 0, width: width, height: height))

        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.quaternarySystemFill.cgColor

        buildChildren()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isFlipped: Bool { true }

    func buildChildren() {
        for i in 0..<count {
            let y = topBottomPadding + CGFloat(i) * rowHeight
            let frame = NSRect(x: sidePadding, y: y, width: fieldWidth, height: rowHeight)

            let tf = NSTextField(labelWithString: "\(i)")
            tf.alignment = .left
            tf.frame = frame

            addSubview(tf)
        }
    }
}
