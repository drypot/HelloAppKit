//
//  TextDocumentViewController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/31/24.
//

import AppKit

class TextDocumentViewController: NSViewController {
    weak var document: TextDocument?
    private var textView = NSTextView()

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

        let padding = 20.0
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let document else { return }
        textView.string = document.content
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        guard let document else { return }
        document.content = textView.string
    }

//    override var representedObject: Any? {
//        didSet {
//            // Update the view, if already loaded.
//        }
//    }

}
