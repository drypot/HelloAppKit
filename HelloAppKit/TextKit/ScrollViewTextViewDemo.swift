//
//  ScrollViewTextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/18/25.
//

import AppKit

class ScrollViewTextViewDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        view.addSubview(scrollView)

        let textView = NSTextView()
        scrollView.documentView = textView

        prepareTextView(textView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    func prepareTextView(_ textView: NSTextView) {
        textView.autoresizingMask = [.width, .height] // 필수다.
        textView.textContainerInset = NSSize(width: 8, height: 8) // 패딩

        textView.isEditable = true
        textView.isSelectable = true

        textView.isRichText = false
        textView.importsGraphics = false

        // 사용자 입력으로 길어지게 만들려면 true.
        textView.isVerticallyResizable = true

        // 사용자 입력으로 길어지게 만들려면 true.
        textView.isHorizontallyResizable = false

        let textContainer = textView.textContainer!

        textContainer.widthTracksTextView = true
        // textContainer.lineBreakMode = .byWordWrapping
        // textContainer.size = .zero  // default: (10000000.0, 10000000.0)

        let font = NSFont.preferredFont(forTextStyle: .title1)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.7

        textView.typingAttributes = [
            .font: font,
            .paragraphStyle: paragraphStyle,
        ]

        textView.string = textSample

        // let attStr = NSAttributedString(
        //     string: textSample,
        //     attributes: [
        //         .font: font,
        //         .paragraphStyle: paragraphStyle,
        //     ]
        // )
        // textView.textStorage!.setAttributedString(attStr)
    }
}
