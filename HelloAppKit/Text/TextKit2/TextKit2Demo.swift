//
//  TextKit2Demo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/31/25.
//

import Cocoa

// TextKit
// https://developer.apple.com/documentation/appkit/textkit

// Meet TextKit 2
// https://developer.apple.com/videos/play/wwdc2021/10061/

class TextKit2Demo: NSViewController {

    private var contentStorage = NSTextContentStorage()
    private var layoutManager = NSTextLayoutManager()
    private var textContainer = NSTextContainer()
    private var textView: NSTextView!

    override func loadView() {
        let view = NSView()
        self.view = view

        let buttonBar = NSStackView()
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.orientation = .horizontal
        view.addSubview(buttonBar)

        do {
            let button = NSButton(title: "Load Sample", target: self, action: #selector(loadSampleAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Add Text", target: self, action: #selector(addTextAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Clear", target: self, action: #selector(clearAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Dump Elements", target: self, action: #selector(dumpElementsAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        view.addSubview(scrollView)

        contentStorage.addTextLayoutManager(layoutManager)
        layoutManager.textContainer = textContainer

        textView = NSTextView(frame: .zero, textContainer: textContainer)
        textView.isEditable = true
        textView.isRichText = false
        textView.font = .monospacedSystemFont(ofSize: 14, weight: .regular)

        // maxSize 설정하고, isVerticallyResizable = true 해야 세로스크롤 할 수 있었다.
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false  // wrap 하려면 false
        textView.textContainer?.widthTracksTextView = true  // wrap 하려면 true
        textView.autoresizingMask = [.width, .height]

        scrollView.documentView = textView

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            buttonBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            buttonBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            scrollView.topAnchor.constraint(equalTo: buttonBar.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    @objc func loadSampleAction(_ sender: NSButton) {
        if let docURL = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
            do {
                try contentStorage.textStorage?.read(from: docURL, documentAttributes: nil, error: ())
            } catch {
                // Could not read menu content.
            }
        }
    }

    @objc func addTextAction(_ sender: NSButton) {
        let titleFont = NSFont.systemFont(ofSize: 24, weight: .bold)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: titleFont
        ]
        let attributedString = NSAttributedString(string: "Hello!\n", attributes: attributes)
        contentStorage.textStorage?.append(attributedString)
    }

    @objc func clearAction(_ sender: NSButton) {
        contentStorage.textStorage?.setAttributedString(NSAttributedString(string: ""))
    }

    @objc func dumpElementsAction(_ sender: NSButton) {
        fatalError()
//        let elements = contentStorage.textElements(for: .)
//        for element in elements {
//            print(element) // NSTextParagraph
//        }
//        contentStorage.textStorage?.setAttributedString(NSAttributedString(string: ""))
    }


}
