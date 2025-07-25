//
//  TextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import AppKit

class TextViewDemo: NSViewController {

    private let textView = NSTextView()

    override func loadView() {
        let view = NSView()
        self.view = view

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        view.addSubview(scrollView)


        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.autoresizingMask = [.width, .height]

        scrollView.documentView = textView

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
            do {
                try textView.textStorage?.read(from: url, documentAttributes: nil, error: ())
            } catch {
                // Could not read menu content.
            }
        }
    }

}
