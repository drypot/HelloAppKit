//
//  AutoLayoutDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class AutoLayoutDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let logger = SizeLogger()
        logger.translatesAutoresizingMaskIntoConstraints = false

        // resize 는 그냥 호출되는데
        // resizeSubviews 호출되는 거 구경하려면 먼가 넣어둬야 한다.
        logger.addSubview(NSView())

        view.addSubview(logger)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            logger.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            logger.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logger.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logger.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
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

