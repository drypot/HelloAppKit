//
//  TextViewTextKit2Demo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/31/25.
//

import Cocoa

// TextKit
// https://developer.apple.com/documentation/appkit/textkit

// Meet TextKit 2
// https://developer.apple.com/videos/play/wwdc2021/10061/

class TextViewTextKit2Demo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let attrString = makeSampleAttrString("TextView TextKit2 Demo")
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
        let textContentStorage = NSTextContentStorage()
        let textStorage = textContentStorage.textStorage!
        let textLayoutManager = NSTextLayoutManager()
        let textContainer = NSTextContainer()

        textContentStorage.addTextLayoutManager(textLayoutManager)
        textLayoutManager.textContainer = textContainer

        let textView = NSTextView(frame: .zero, textContainer: textContainer)

        textView.autoresizingMask = [.width, .height] // 필수다.
        textView.textContainerInset = NSSize(width: 8, height: 8) // 패딩

        textView.isEditable = true
        textView.isSelectable = true

        textView.isRichText = false
        textView.importsGraphics = false

        // 사용자 입력에 따라 컨트롤이 계속 커지게 만들려면 true.
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false // **
        textView.maxSize = NSSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )

        // Wrap 모드면 true
        textContainer.widthTracksTextView = true // **
        textContainer.size = NSSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )

        textView.typingAttributes = attrString.attributes(at: 0, effectiveRange: nil)

        textContentStorage.performEditingTransaction {
            textStorage.append(attrString)
        }

        return textView
    }

    func prepareScrollView(_ textView: NSTextView) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false // **
        return scrollView
    }

}
