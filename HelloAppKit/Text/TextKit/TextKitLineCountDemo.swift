//
//  TextKitLineCountDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/29/25.
//

import AppKit

class TextKitLineCountDemo: NSViewController {

    private let textView = NSTextView()
    private var previousFrameSize = NSSize.zero

    override func loadView() {
        let view = NSView()
        self.view = view

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        view.addSubview(scrollView)

//        AutoresizingMask 써야 textView Size 를 쉽게 자동세팅할 수 있다.
//        textView.translatesAutoresizingMaskIntoConstraints = false

        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.autoresizingMask = [.width, .height]
//        textView.font = .systemFont(ofSize: 24.0)

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
//        textView.string = "NSTextView Demo"
    }

    override func viewDidLayout() {
        guard previousFrameSize != view.frame.size else { return }
        previousFrameSize = view.frame.size

        let layoutManager = textView.layoutManager!
        let numberOfGlyphs = layoutManager.numberOfGlyphs

        var lineFragmentCount = 0
        var index = 0

        while (index < numberOfGlyphs) {
            var effectiveRange = NSRange()
            layoutManager.lineFragmentRect(
                forGlyphAt: index,
                effectiveRange: &effectiveRange
            )
            index = NSMaxRange(effectiveRange)
            lineFragmentCount += 1
        }
        print("lineFragment count: \(lineFragmentCount)")
    }

}
