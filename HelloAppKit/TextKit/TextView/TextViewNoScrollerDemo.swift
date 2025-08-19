//
//  TextViewNoScrollerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/18/25.
//

import AppKit

class TextViewNoScrollerDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let attrString = makeSampleAttrString("TextView NoScroller Demo")
        let textView = TextViewFactory.makeTextView(attrString)
        TextViewFactory.configureForNoScroller(textView)
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

}
