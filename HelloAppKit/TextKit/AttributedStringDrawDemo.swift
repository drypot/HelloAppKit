//
//  AttributedStringDrawDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/26/25.
//


import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

class AttributedStringDrawDemo: NSViewController {

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

        stackView.addArrangedSubview(CustomTextView())
    }

    class CustomTextView: NSView {

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

            let text = "Hello"
            let attrs: [NSAttributedString.Key: Any] = [
                .font: NSFont.preferredFont(forTextStyle: .title1),
                .foregroundColor: NSColor.black
            ]

            let textSize = text.size(withAttributes: attrs)
            let textOrigin = NSPoint(
                x: 0,
                y: bounds.height - textSize.height
            )
//            let textOrigin = NSPoint(
//                x: (bounds.width - textSize.width) / 2,
//                y: (bounds.height - textSize.height) / 2
//            )

            text.draw(at: textOrigin, withAttributes: attrs)
        }
    }

}
