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

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])

        stackView.addArrangedSubview(StringDrawDemo())
        stackView.addArrangedSubview(LayoutManagerDemo())
    }

    class StringDrawDemo: NSView {

        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            wantsLayer = true
            layer?.backgroundColor = NSColor.textBackgroundColor.cgColor
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override var intrinsicContentSize: NSSize {
            return NSSize(width: 400, height: 120)
        }

        override func draw(_ dirtyRect: NSRect) {
            super.draw(dirtyRect)

            let text = "StringDrawDemo"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: NSFont.preferredFont(forTextStyle: .title1),
                .foregroundColor: NSColor.black
            ]

            let textSize = text.size(withAttributes: attributes)
            let textOrigin = NSPoint(
                x: 0,
                y: bounds.height - textSize.height
            )
//            let textOrigin = NSPoint(
//                x: (bounds.width - textSize.width) / 2,
//                y: (bounds.height - textSize.height) / 2
//            )

            text.draw(at: textOrigin, withAttributes: attributes)
        }
    }

    class LayoutManagerDemo: NSView {
        private var textStorage = NSTextStorage()
        private var layoutManager = NSLayoutManager()
        private var textContainer = NSTextContainer(size: .zero)

        override init(frame frameRect: NSRect) {
            textContainer.lineFragmentPadding = 0 // 좌우 패딩 삭제

            textStorage.addLayoutManager(layoutManager)
            layoutManager.addTextContainer(textContainer)

            super.init(frame: frameRect)

            wantsLayer = true
            layer?.backgroundColor = NSColor.textBackgroundColor.cgColor
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override var intrinsicContentSize: NSSize {
            return NSSize(width: 400, height: 120)
        }

        override func layout() {
            super.layout()
            textContainer.size = bounds.size
        }

//        override var isFlipped: Bool { true }

        override func draw(_ dirtyRect: NSRect) {
            super.draw(dirtyRect)

            let text = "LayoutManagerDemo"

//            let font = NSFont.preferredFont(forTextStyle: .title1)
            let font = NSFont.systemFont(ofSize: 36)

//            let paragraphStyle = NSMutableParagraphStyle()
//            let lineHeight: CGFloat = font.pointSize * 1.0
//            paragraphStyle.minimumLineHeight = lineHeight
//            paragraphStyle.maximumLineHeight = lineHeight

            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
//                .paragraphStyle: paragraphStyle,
                .foregroundColor: NSColor.black
            ]
            let attrString = NSAttributedString(string: text, attributes: attributes)

            textStorage.setAttributedString(attrString)

            let glyphRange = layoutManager.glyphRange(for: textContainer)

            let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
            print(boundingRect)

            let usedRect = layoutManager.usedRect(for: textContainer)
            print(usedRect)

            let textOrigin = NSPoint(
                x: 0,
                y: bounds.height - usedRect.height
            )

            layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: textOrigin)

            //

//            let path = NSBezierPath()
//            path.move(to: NSPoint(x: 0, y: usedRect.height))
//            path.line(to: NSPoint(x: 50, y: usedRect.height))

            let path = NSBezierPath()
            path.appendRect(usedRect.offsetBy(dx: 0, dy: bounds.height - usedRect.height))
//            path.appendRect(usedRect)

            NSColor.black.setStroke()

            path.lineWidth = 1
            path.stroke()
        }
    }

}
