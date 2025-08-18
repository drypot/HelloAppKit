//
//  TextViewScrollViewNoWrapDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/18/25.
//

import AppKit

class TextViewScrollViewNoWrapDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let attrString = makeSampleAttrString("TextView ScrollView NoWrap Demo")
        let textView = prepareTextView(attrString)
        let scrollView = prepareScrollView(textView)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    func prepareTextView(_ attrString: NSAttributedString) -> NSTextView {
        let textView = NSTextView()
        let textContainer = textView.textContainer!

        textView.autoresizingMask = [.width, .height] // 필수다.
        textView.textContainerInset = NSSize(width: 8, height: 8) // 패딩

        textView.isEditable = true
        textView.isSelectable = true

        textView.isRichText = false
        textView.importsGraphics = false

        // 사용자 입력에 따라 컨트롤이 계속 커지게 만들려면 true.
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true // **
        textView.maxSize = NSSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )

        // NoWrap 모드면 textContainer 사이즈를 무한대로 주고 widthTracking 을 끈다.
        textContainer.widthTracksTextView = false // **
        textContainer.size = NSSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )

        textView.typingAttributes = attrString.attributes(at: 0, effectiveRange: nil)
        textView.textContentStorage!.textStorage!.append(attrString)

        return textView
    }

    func prepareScrollView(_ textView: NSTextView) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true // **
        return scrollView
    }
}
