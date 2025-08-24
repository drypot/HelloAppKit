//
//  TextViewDelegateDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/20/25.
//

import Cocoa

// TextKit
// https://developer.apple.com/documentation/appkit/textkit

// Meet TextKit 2
// https://developer.apple.com/videos/play/wwdc2021/10061/

class TextViewDelegateDemo: NSViewController, NSTextLayoutManagerDelegate {

    override func loadView() {
        let view = NSView()
        self.view = view

        let textView = TextViewFactory.makeTextView()
        textView.typingAttributes = makeSampleAttr()
        textView.string = "TextView Delegate Demo\n\n" + textSample
        let scrollView = TextViewFactory.makeScrollView(containing: textView)
        view.addSubview(scrollView)

        textView.textLayoutManager!.delegate = self

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    // 추후에 ...

}
