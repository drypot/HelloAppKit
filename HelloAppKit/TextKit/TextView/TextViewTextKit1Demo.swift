//
//  TextViewTextKit1Demo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/31/25.
//

import Cocoa

// TextKit
// https://developer.apple.com/documentation/appkit/textkit

class TextViewTextKit1Demo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let textView = TextViewFactory.makeTextViewTK1()
        textView.typingAttributes = makeSampleAttr()
        textView.string = "TextView TextKit1 Demo\n\n" + textSample
        let scrollView = TextViewFactory.makeScrollView(textView)
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
