//
//  TextKit1DrawDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/26/25.
//


import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

class TextKit1DrawDemo: NSViewController {

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

    class CustomTextView: NSView {

        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)

            // 화면 확인을 위해 바닥에 흰색을 깐다.
            wantsLayer = true
            layer?.backgroundColor = NSColor.textBackgroundColor.cgColor
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // override var isFlipped: Bool { true }

        override func draw(_ dirtyRect: NSRect) {
            super.draw(dirtyRect)

            let textStorage = NSTextStorage()
            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: .zero)

            textStorage.addLayoutManager(layoutManager)
            layoutManager.addTextContainer(textContainer)

            let font = NSFont.preferredFont(forTextStyle: .title1)

            let attStr = NSAttributedString(
                string: "Hello",
                attributes: [
                    .font: font,
                    .foregroundColor: NSColor.black
                ]
            )

            textStorage.setAttributedString(attStr)

            let glyphRange = layoutManager.glyphRange(for: textContainer)

            // let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
            // print(boundingRect)

            let usedRect = layoutManager.usedRect(for: textContainer)
            // print(usedRect)

            let textOrigin = NSPoint(
                x: 0,
                y: bounds.height - font.ascender - font.descender - usedRect.height
                // 왜 usedRect.height 까지 빼야하는지 모르겠다;
                // 하다 보니 그냥 이렇게 하면 대강 맞는다;
                // 담에 다시 보자;
            )

            layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: textOrigin)

            //

            NSColor.black.setStroke()

            // let path = NSBezierPath()
            // path.move(to: NSPoint(x: 0, y: usedRect.height))
            // path.line(to: NSPoint(x: 50, y: usedRect.height))

            let path = NSBezierPath(
                rect: NSRect(
                    origin: NSPoint(x: 0, y: bounds.height - usedRect.height),
                    size: usedRect.size
                )
            )
            path.lineWidth = 1
            path.stroke()
        }
    }

}
