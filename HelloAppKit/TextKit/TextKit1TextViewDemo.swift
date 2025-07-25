//
//  TextKit2TextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/31/25.
//

import Cocoa

// TextKit
// https://developer.apple.com/documentation/appkit/textkit

class TextKit1TextViewDemo: NSViewController {

    private var textView: NSTextView?

//    private weak var contentStorage: NSTextContentStorage? // TK2
    private weak var textStorage: NSTextStorage?

//    private weak var layoutManager: NSTextLayoutManager?  // TK2
    private weak var layoutManager: NSLayoutManager?

    private weak var container: NSTextContainer?

    override func loadView() {
        let view = NSView()
        self.view = view

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])

        setupButtonBar()
        setupTextView()
    }

    func setupButtonBar() {
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
            let button = NSButton(title: "Set text", target: self, action: #selector(setTextAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Add text", target: self, action: #selector(addTextAction))
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
            let button = NSButton(title: "Line fragments", target: self, action: #selector(lineFragmentsAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Wrap", target: self, action: #selector(wrapAction))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            buttonBar.addArrangedSubview(button)
        }

        NSLayoutConstraint.activate([
            buttonBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            buttonBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    func setupTextView() {
        let textView = NSTextView(frame: .zero)
        self.textView = textView

        textView.isEditable = true
        textView.isRichText = false
        textView.font = .monospacedSystemFont(ofSize: 18, weight: .regular)
        // maxSize 설정하고, isVerticallyResizable = true 해야 세로스크롤 할 수 있었다.
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false  // wrap 하려면 false
        textView.textContainer?.widthTracksTextView = true  // wrap 하려면 true
        textView.autoresizingMask = [.width, .height]

        self.layoutManager = textView.layoutManager
//        self.layoutManager = textView.textLayoutManager  // TK2

        self.textStorage = textView.textStorage
//        self.contentStorage = layoutManager!.textContentManager as? NSTextContentStorage // TK2
//        self.textStorage = contentStorage!.textStorage

        self.container = textView.textContainer
//        self.container = layoutManager!.textContainer // TK2

        let lastSubview = view.subviews.last!

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.documentView = textView
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    @objc func loadSampleAction(_ sender: NSButton) {
        if let docURL = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
            do {
                textStorage!.setAttributedString(NSAttributedString(string: ""))
                try textStorage!.read(from: docURL, documentAttributes: nil, error: ())
            } catch {
                print("read error")
            }
        }
    }

    @objc func setTextAction(_ sender: NSButton) {
        let text = "Hello, TextKit 1!\nparagraph1.\nparagraph2.\nparagraph3.\n"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.preferredFont(forTextStyle: .title1),
        ]
        let attrString = NSAttributedString(string: text, attributes: attributes)
        textStorage!.setAttributedString(attrString)
    }

    @objc func addTextAction(_ sender: NSButton) {
        let text = "Some extra text.\n"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.preferredFont(forTextStyle: .title1),
        ]
        let attrString = NSAttributedString(string: text, attributes: attributes)
        textStorage!.append(attrString)
    }

    @objc func clearAction(_ sender: NSButton) {
        textStorage!.setAttributedString(NSAttributedString(string: ""))
    }

    @objc func lineFragmentsAction(_ sender: NSButton) {
        let layoutManager = self.layoutManager!
        let numberOfGlyphs = layoutManager.numberOfGlyphs

        print("Glyphs count: \(numberOfGlyphs)")

        var lineFragmentCount = 0
        var index = 0

        while (index < numberOfGlyphs) {
            var effectiveRange = NSRange()
            let rect = layoutManager.lineFragmentRect(
                forGlyphAt: index,
                effectiveRange: &effectiveRange
            )
            print("rect: \(rect)")
            index = NSMaxRange(effectiveRange)
            lineFragmentCount += 1
        }
        print("Line fragments count: \(lineFragmentCount)")
    }

    @objc func wrapAction(_ sender: NSButton) {
        let scrollView = textView!.enclosingScrollView!
        let textView = self.textView!
        let container = self.container!
        if container.widthTracksTextView {
            container.widthTracksTextView = false
            container.size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            textView.isHorizontallyResizable = true
            textView.autoresizingMask = [.height]
            scrollView.hasHorizontalScroller = true
        } else {
            container.widthTracksTextView = true
            container.size = CGSize(width: 0, height: CGFloat.greatestFiniteMagnitude)
            textView.isHorizontallyResizable = false
            textView.autoresizingMask = [.width, .height]
            textView.frame.size.width = scrollView.contentSize.width
            scrollView.hasHorizontalScroller = false
        }
        textView.needsDisplay = true
    }


}
