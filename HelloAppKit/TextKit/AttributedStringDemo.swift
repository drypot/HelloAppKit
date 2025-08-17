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

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        view.addSubview(stackView)

        addStackItems(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func addStackItems(_ stackView: NSStackView) {
        let textView = NSTextView()
        let storage = textView.textStorage!

        stackView.addArrangedSubview(textView)

        let font = NSFont.preferredFont(forTextStyle: .title1)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        // paragraphStyle.lineSpacing = font.pointSize * 0.7

        do {
            var attrStr = AttributedString("Hello, AppKit + AttributedString!")
            attrStr.foregroundColor = .systemBlue

            // Conformance of 'NSFont' to 'Sendable' is unavailable 오류가 난다.
            // AttributedString.font 는 SwiftUI.Font 를 받는다고 한다.
            // NSFont 를 바로 넣으려면 문제가 생긴다.
            //
            // attrStr.font = font

            // 다음과 같이 해야 한다는데 AppKit 에서는 걍 NSAttributedString 쓰는 게 낫겠다.
            attrStr.mergeAttributes(AttributeContainer([.font: font]))

            // 부분 스타일링
            if let range = attrStr.range(of: "AttributedString") {
                attrStr[range].foregroundColor = .systemRed
                attrStr[range].underlineStyle = .single
            }
            storage.append(NSAttributedString(attrStr))
        }
    }
    
}
