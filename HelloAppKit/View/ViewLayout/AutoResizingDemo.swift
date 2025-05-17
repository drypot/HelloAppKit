//
//  AutoResizingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class AutoResizingDemo: NSViewController {

    var logger: SizeLogger?

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        logger = SizeLogger(frame: .zero)
        logger!.autoresizingMask = [.width, .height]

        // resize 는 그냥 호출되는데
        // resizeSubviews 호출되는 거 구경하려면 먼가 넣어둬야 한다.
        logger!.addSubview(NSView())

        view.addSubview(logger!)
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        print("---")
        print("viewDidLayout: \(view.frame.size)")
    }

    class SizeLogger: NSView {

        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            wantsLayer = true
            layer?.backgroundColor = NSColor.systemTeal.cgColor
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func resizeSubviews(withOldSize oldSize: NSSize) {
            super.resizeSubviews(withOldSize: oldSize)
            print("resizeSubviews: \(frame.size)")
        }

        override func resize(withOldSuperviewSize oldSize: NSSize) {
            super.resize(withOldSuperviewSize: oldSize)
            print("resize: \(frame.size)")
        }

        override func layout() {
            super.layout()
            print("layout: \(frame.size)")
        }
    }

}

