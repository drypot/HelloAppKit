//
//  NSAttributedStringDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import AppKit

// Mastering macOS programming-Packt Publishing (2017), 209p

class NSAttributedStringDemo: NSViewController {

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
//        paragraphStyle.lineSpacing = font.pointSize * 0.7

        do {
            let attStr = NSMutableAttributedString(
                string: "Hello Attributions!\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: NSColor.darkGray,
                    .backgroundColor: NSColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0),
                ]
            )
            storage.append(attStr)
        }
        do {
            let attStr = NSMutableAttributedString(
                string: "Hello Attributions! addAttribute.\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: NSColor.textColor,
                ]
            )
            let range = (attStr.string as NSString).range(of: "Attributions!")
            attStr.addAttribute(.foregroundColor, value: NSColor.blue, range: range)
            storage.append(attStr)
        }
        do {
            let attStr = NSMutableAttributedString(
                string: "Hello Attributions! addAttributes.\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: NSColor.black,
                ]
            )
            let range = (attStr.string as NSString).range(of: "Attributions!")
            attStr.addAttributes(
                [
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle,
                    .strokeWidth: 2.0,
                ],
                range: range
            )
            storage.append(attStr)
        }
        do {
            let attStr = NSMutableAttributedString(
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
            let range = (attStr.string as NSString).range(of: "Attributions!")
            attStr.addAttribute(.shadow, value: myShadow, range: range)
            storage.append(attStr)
        }
        do {
            let attStr = NSMutableAttributedString(
                string: "https://www.apple.com\n",
                attributes: [
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .link: "https://www.apple.com",
                ]
            )
            storage.append(attStr)
        }

    }
    
}
