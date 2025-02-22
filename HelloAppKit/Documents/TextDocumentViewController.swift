//
//  TextDocumentViewController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/31/24.
//

import AppKit

class TextDocumentViewController: NSViewController {

    var textView = NSTextView()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = NSFont.systemFont(ofSize: 24.0)

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.documentView = textView

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
    }

//    override var representedObject: Any? {
//        didSet {
//            // Update the view, if already loaded.
//        }
//    }

}
