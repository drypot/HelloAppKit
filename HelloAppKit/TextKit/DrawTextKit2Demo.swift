//
//  DrawTextKit2Demo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/19/25.
//


import AppKit

class DrawTextKit2Demo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let customTextView = CustomTextView()
        customTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTextView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            customTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            customTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

}

fileprivate class CustomTextView: NSView {

    let textContentStorage = NSTextContentStorage()
    let textLayoutManager = NSTextLayoutManager()
    let textContainer = NSTextContainer(size: .zero)

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        textContentStorage.addTextLayoutManager(textLayoutManager)
        textLayoutManager.textContainer = textContainer

        textContainer.lineFragmentPadding = 0 // 좌우 패딩 제거

        let attrString = makeSampleAttrString("Draw TextKit2 Demo")
        setText(attrString)

        wantsLayer = true
        layer?.backgroundColor = NSColor.quaternaryLabelColor.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isOpaque: Bool { true }
    override var isFlipped: Bool { true }

    func setText(_ string: NSAttributedString) {
        textContentStorage.textStorage!.setAttributedString(string)
        textLayoutManager.invalidateLayout(for: textLayoutManager.documentRange)
        needsDisplay = true
    }

    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        textContainer.size = bounds.size
//        textLayoutManager.textViewportLayoutController.viewportRange = nil // (선택) 뷰포트 재설정
        needsDisplay = true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let docRange = textLayoutManager.documentRange
        textLayoutManager.ensureLayout(for: docRange)

        let context = NSGraphicsContext.current!.cgContext

        textLayoutManager.enumerateTextLayoutFragments(from: docRange.location, options: []) { fragment in
            let fragmentFrame = fragment.layoutFragmentFrame
            fragment.draw(at: fragmentFrame.origin, in: context)
            return true
        }

//        NSColor.textColor.setStroke()
//        let usedRect = textLayoutManager.usedRect(for: textContainer)
//        let path = NSBezierPath(rect: NSRect(origin: origin, size: usedRect.size))
//        path.stroke()
    }

}
