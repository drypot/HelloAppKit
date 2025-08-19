//
//  TextViewNoWrapDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/18/25.
//

import AppKit

class TextViewNoWrapDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let attrString = makeSampleAttrString("TextView NoWrap Demo")
        let textView = TextViewFactory.makeTextView(attrString)
        let scrollView = TextViewFactory.makeScrollView(textView)
        TextViewFactory.configureForNoWrap(textView, scrollView)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

}
