//
//  TextStorageDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/30/24.
//

import AppKit

class TextStorageDemo: NSViewController {

    var textStorage = NSTextStorage()
    var layoutManager = NSLayoutManager()
    var textContainer = NSTextContainer()
    var textView: NSTextView = NSTextView()
    var scrollview = NSScrollView()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        textView.textContainer = textContainer
        textView.string = "Hello, World!"
        textView.font = NSFont(name: "Helvetica", size: 24.0)

        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.documentView = textView

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
//            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

}
