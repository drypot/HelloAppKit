//
//  ScrollableTextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/18/25.
//

import AppKit

class ScrollableTextViewDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let scrollView = prepareScrollableTextView()
        view.addSubview(scrollView)

        let textView = scrollView.documentView as! NSTextView
        setTextViewContent(textView, title: "NSTextView.scrollableTextView() Demo")

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    func prepareScrollableTextView() -> NSScrollView {
        // let scrollView = NSTextView.scrollablePlainDocumentContentTextView()
        let scrollView = NSTextView.scrollableTextView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false // 필수다.

        // 스크롤 붙이려면 true.
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false // **

        let textView = scrollView.documentView as! NSTextView
        prepareTextView(textView)

        return scrollView
    }

    func prepareTextView(_ textView: NSTextView) {
        let textContainer = textView.textContainer!

        //textView.autoresizingMask = [.width, .height]  // 이미 세팅되어 있는 듯
        textView.textContainerInset = NSSize(width: 8, height: 8) // 패딩

        textView.isEditable = true
        textView.isSelectable = true

        textView.isRichText = false
        textView.importsGraphics = false

        // 사용자 입력에 따라 컨트롤이 계속 커지게 만들려면 true.
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false // **

        // Wrap 모드면 true
        textContainer.widthTracksTextView = true // **
    }

    func setTextViewContent(_ textView: NSTextView, title: String) {
        let font = NSFont.preferredFont(forTextStyle: .title1)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3

        textView.typingAttributes = [
            .font: font,
            .paragraphStyle: paragraphStyle,
        ]

        textView.string = title + "\n\n" + textSample

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
