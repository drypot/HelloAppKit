//
//  TextDrawDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/26/25.
//


import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

class TextDrawDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let stringDrawDemo = StringDrawDemo()
        stringDrawDemo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stringDrawDemo)

        let layoutManagerDemo = LayoutManagerDemo()
        layoutManagerDemo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(layoutManagerDemo)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            stringDrawDemo.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stringDrawDemo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stringDrawDemo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stringDrawDemo.heightAnchor.constraint(equalToConstant: 80),

            layoutManagerDemo.topAnchor.constraint(equalTo: stringDrawDemo.topAnchor, constant: 80),
            layoutManagerDemo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            layoutManagerDemo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            layoutManagerDemo.heightAnchor.constraint(equalToConstant: 80),

        ])
    }

    class StringDrawDemo: NSView {
        override func draw(_ dirtyRect: NSRect) {
            super.draw(dirtyRect)

            let text = "NSString Draw" as NSString
            let attributes: [NSAttributedString.Key: Any] = [
                .font: NSFont.preferredFont(forTextStyle: .title3),
                .foregroundColor: NSColor.black
            ]

            let textSize = text.size(withAttributes: attributes)
            let textOrigin = NSPoint(
                x: (bounds.width - textSize.width) / 2,
                y: (bounds.height - textSize.height) / 2
            )

            text.draw(at: textOrigin, withAttributes: attributes)
        }
    }

    class LayoutManagerDemo: NSView {

        private var textStorage = NSTextStorage()
        private var layoutManager = NSLayoutManager()
        private var textContainer: NSTextContainer

        override init(frame frameRect: NSRect) {
            let attributedString = NSAttributedString(
                string: "NSLayoutManager drawGlyphs",
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
