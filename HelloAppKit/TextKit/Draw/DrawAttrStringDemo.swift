//
//  DrawAttrStringDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/26/25.
//

import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

class DrawAttrStringDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let customView = CustomTextView()
        view.addSubview(customView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

}

fileprivate class CustomTextView: NSView {

    let attrString = makeSampleAttrString(title: "Draw NSString Demox\n\n")

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.textBackgroundColor.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override var isOpaque: Bool { true }
//    override var isFlipped: Bool { true }

    override var intrinsicContentSize: NSSize {
        return NSSize(width: 400, height: 120)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        attrString.draw(at: .zero)
    }
}
