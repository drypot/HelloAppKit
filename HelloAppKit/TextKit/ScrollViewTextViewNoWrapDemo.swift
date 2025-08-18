//
//  ScrollViewTextViewNoWrapDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/18/25.
//

import AppKit

class ScrollViewTextViewNoWrapDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let scrollView = prepareScrollableTextView()
        view.addSubview(scrollView)

        let textView = scrollView.documentView as! NSTextView
        setTextViewContent(textView, title: "ScrollView+TextView NoWrap Demo")

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
        let textView = prepareTextView()

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = textView

        // 스크롤 붙이려면 true.
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true // **

        return scrollView
    }

    func prepareTextView() -> NSTextView {
        let textView = NSTextView()
        let textContainer = textView.textContainer!

        textView.autoresizingMask = [.width, .height] // 필수다.
        textView.textContainerInset = NSSize(width: 8, height: 8) // 패딩

        textView.isEditable = true
        textView.isSelectable = true

        textView.isRichText = false
        textView.importsGraphics = false

        // NoWrap 모드에서 커서가 오른쪽 벽 너머로 사라지는 현상을 해결하려면 maxSize 를 세팅한다.
        textView.maxSize = NSSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )

        // 사용자 입력에 따라 컨트롤이 계속 커지게 만들려면 true.
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true // **

        // NoWrap 모드면 textContainer 사이즈를 무한대로 주고 widthTracking 을 끈다.
        textContainer.widthTracksTextView = false // **
        textContainer.size = NSSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )

        return textView
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
