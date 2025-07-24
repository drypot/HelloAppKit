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

//            let font = NSFont.systemFont(ofSize: 16)
            let font = NSFont.preferredFont(forTextStyle: .title1)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: NSColor.black
            ]

            textStorage.setAttributedString(NSAttributedString(string: text, attributes: attributes))


            let glyphRange = layoutManager.glyphRange(for: textContainer)

            let usedRect = layoutManager.usedRect(for: textContainer)
            print(usedRect)
            print(usedRect.origin)

            let textOrigin = NSPoint(
                x: 0,
                y: 0
            )


            layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: textOrigin)

            let boundingRect = layoutManager.boundingRect(
                forGlyphRange: glyphRange,
                in: textContainer
            )

            print(boundingRect)
            //

            NSColor.black.setStroke()

            let startPoint = NSPoint(x: 0, y: usedRect.height)
            let endPoint = NSPoint(x: 50, y: usedRect.height)

            // 선 색상 설정
            NSColor.black.setStroke()

            // 선 경로 설정
            let path = NSBezierPath()
            path.move(to: startPoint)
            path.line(to: endPoint)
            path.lineWidth = 2  // 선 두께 설정

            path.stroke()
        }
    }

}
