//
//  AttributedStringDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/17/25.
//

import AppKit

// Mastering macOS programming-Packt Publishing (2017), 209p

class AttributedStringDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let attrString = NSAttributedString(makeAttrString())
        let textView = TextViewFactory.makeTextView(attrString)
        let scrollView = TextViewFactory.makeScrollView(textView)
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

    func makeAttrString() -> AttributedString {
        let font = NSFont.preferredFont(forTextStyle: .title1)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.7

        var attrString = AttributedString("Hello, AppKit + AttributedString!")

        attrString.foregroundColor = .systemBlue

        // Conformance of 'NSFont' to 'Sendable' is unavailable 오류가 난다.
        // AttributedString.font 는 SwiftUI.Font 를 받는다고 한다.
        // NSFont 를 바로 넣으려면 문제가 생긴다.
        //
        // attrStr.font = font
        //
        // 다음과 같이 해야 한다는데 AppKit 에서는 걍 NSAttributedString 쓰는 게 낫겠다.

        attrString.mergeAttributes(AttributeContainer([.font: font]))

        // 부분 스타일링
        if let range = attrString.range(of: "AttributedString!") {
            attrString[range].foregroundColor = .systemRed
            attrString[range].underlineStyle = .single
        }

        return attrString
    }

}
