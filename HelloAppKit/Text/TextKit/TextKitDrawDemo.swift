//
//  TextKitDrawDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/26/25.
//

import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

// Putting an NSTextView Object in an NSScrollView
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextUILayer/Tasks/TextInScrollView.html#//apple_ref/doc/uid/20000938

class TextKitDrawDemo: NSViewController {

    private let demoView = DemoView()

    override func loadView() {
        let view = NSView()
        self.view = view

        demoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(demoView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            demoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            demoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            demoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            demoView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

    class DemoView: NSView {

        private var textStorage = NSTextStorage()
        private var layoutManager = NSLayoutManager()
        private var textContainer: NSTextContainer

        override init(frame frameRect: NSRect) {
            let attributedString = NSAttributedString(
                string: "layoutManager.drawGlyphs(forGlyphRange:at:)",
                attributes: [
                    .font: NSFont.systemFont(ofSize: 24),
                    .foregroundColor: NSColor.black
                ]
            )
            textStorage.setAttributedString(attributedString)

            textContainer = NSTextContainer(size: frameRect.size)
            textContainer.lineFragmentPadding = 5.0

            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)

            super.init(frame: frameRect)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func draw(_ dirtyRect: NSRect) {
            super.draw(dirtyRect)

            let textRange = layoutManager.glyphRange(for: textContainer)
            let usedRect = layoutManager.usedRect(for: textContainer)
            let textOrigin = NSPoint(
                x: (bounds.width - usedRect.width) / 2,
                y: (bounds.height - usedRect.height) / 2
            )

            layoutManager.drawGlyphs(forGlyphRange: textRange, at: textOrigin)
        }

        override func layout() {
            super.layout()
            textContainer.size = bounds.size
//            setNeedsDisplay(bounds)
        }
    }

}
