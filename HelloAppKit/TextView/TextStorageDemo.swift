//
//  TextStorageDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/30/24.
//

import AppKit

class TextStorageDemoController: NSViewController {

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

        let padding = 20.0
        NSLayoutConstraint.activate([
//            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

}
