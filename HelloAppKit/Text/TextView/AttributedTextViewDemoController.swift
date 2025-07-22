//
//  AttributedTextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import AppKit

// Mastering macOS programming-Packt Publishing (2017), 209p

class AttributedTextViewDemo: NSViewController {

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
        let str1 = NSMutableAttributedString(string: "Hello attributions!\n")
        str1.addAttribute(.foregroundColor, value: NSColor.brown, range: NSRange(location: 6, length: 12))

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: NSColor.darkGray,
            .backgroundColor: NSColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0),
            .font: NSFont(name: "Courier", size: 18.0)! /* Optional 들은 꼭 벗겨서 넣어야 한다 */
        ]
        let str2 = NSMutableAttributedString(string: "Great to be here\n", attributes: attributes)
        str1.append(str2)

        let linkAttributes: [NSAttributedString.Key: Any] = [.link: "http://www.grimshaw.de"]
        let str3 = NSMutableAttributedString(string: "Click me\n", attributes: linkAttributes)
        str1.append(str3)

        let emphasisTextAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle,
            .foregroundColor: NSColor.black,
            .strokeWidth : 2.0
        ]
        let str4 = NSMutableAttributedString(string: "Great to be here\n")
        str4.addAttributes(emphasisTextAttributes, range: NSRange(location: 9, length: 2))
        str1.append(str4)

        let str5 = NSMutableAttributedString(string: "Great to be here\n")
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 1
        myShadow.shadowOffset = CGSize(width: 8, height: -8)
        myShadow.shadowColor = NSColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        str5.addAttribute(.shadow, value: myShadow, range: NSRange(location: 0, length: 8))
        str1.append(str5)

        str1.addAttribute(.font, value: NSFont.systemFont(ofSize: 32), range: NSRange(location: 0, length: str1.length))

        let textView = NSTextView()
        textView.textStorage?.setAttributedString(str1)
        stackView.addArrangedSubview(textView)

        NSLayoutConstraint.activate([
            textView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400)
        ])
    }
}
