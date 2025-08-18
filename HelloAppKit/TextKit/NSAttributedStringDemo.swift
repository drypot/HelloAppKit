//
//  NSAttributedStringDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import AppKit

class NSAttributedStringDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let attrString = makeAttrString()
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

    func makeAttrString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        let font = NSFont.preferredFont(forTextStyle: .title1)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.7

        do {
            let attrString = NSMutableAttributedString(
                string: "Hello Attributions!\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: NSColor.darkGray,
                    .backgroundColor: NSColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0),
                ]
            )
            result.append(attrString)
        }
        do {
            let attrString = NSMutableAttributedString(
                string: "Hello Attributions! addAttribute.\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: NSColor.textColor,
                ]
            )
            attrString.addAttribute(
                .foregroundColor,
                value: NSColor.blue,
                range: (attrString.string as NSString).range(of: "Attributions!")
            )
            result.append(attrString)
        }
        do {
            let attrString = NSMutableAttributedString(
                string: "Hello Attributions! addAttributes.\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: NSColor.black,
                ]
            )
            attrString.addAttributes(
                [
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle,
                    .strokeWidth: 2.0,
                ],
                range: (attrString.string as NSString).range(of: "Attributions!")
            )
            result.append(attrString)
        }
        do {
            let attrString = NSMutableAttributedString(
                string: "Hello Attributions! NSShadow.\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: NSColor.black,
                ]
            )
            let myShadow = NSShadow()
            myShadow.shadowBlurRadius = 1
            myShadow.shadowOffset = CGSize(width: 8, height: -8)
            myShadow.shadowColor = NSColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
            attrString.addAttribute(
                .shadow,
                value: myShadow,
                range: (attrString.string as NSString).range(of: "Attributions!")
            )
            result.append(attrString)
        }
        do {
            let attrString = NSMutableAttributedString(
                string: "https://www.apple.com\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .link: "https://www.apple.com",
                ]
            )
            result.append(attrString)
        }

        return result
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
        textView.textContentStorage!.textStorage!.append(attrString)

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
