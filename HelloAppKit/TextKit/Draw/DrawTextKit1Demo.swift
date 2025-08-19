//
//  DrawTextKit1Demo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/26/25.
//


import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

class DrawTextKit1Demo: NSViewController {

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

    let textStorage = NSTextStorage()
    let layoutManager = NSLayoutManager()
    let textContainer = NSTextContainer(size: .zero)

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        let attrString = makeSampleAttrString("Draw TextKit1 Demo")
        textStorage.setAttributedString(attrString)

        textContainer.lineFragmentPadding = 0 // 좌우 패딩 제거

        wantsLayer = true
        layer?.backgroundColor = NSColor.quaternaryLabelColor.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isFlipped: Bool { true }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        textContainer.size = bounds.size

        let glyphRange = layoutManager.glyphRange(for: textContainer)
        let origin = CGPoint(x: 0.0, y: 0.0)

        layoutManager.drawBackground(forGlyphRange: glyphRange, at: origin)
        layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: origin)

        NSColor.textColor.setStroke()
        let usedRect = layoutManager.usedRect(for: textContainer)
        let path = NSBezierPath(rect: NSRect(origin: origin, size: usedRect.size))
        path.stroke()
    }

}
