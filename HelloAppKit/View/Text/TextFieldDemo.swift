//
//  TextFieldDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/16/25.
//

import Cocoa

class TextFieldDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        // Setup StackView

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])

        // Setup StackItems

        do {
            let text = NSTextField(labelWithString: "Text 1")
            text.font = .systemFont(ofSize: 24)
            stackView.addArrangedSubview(text)
        }

        do {
            var string = AttributedString("Attributed string")
            var container = AttributeContainer()
            container[AttributeScopes.AppKitAttributes.ForegroundColorAttribute.self] = .systemRed
            string.mergeAttributes(container, mergePolicy: .keepNew)

            let text = NSTextField()
            text.attributedStringValue = NSAttributedString(string)
            text.font = .systemFont(ofSize: 24)
            text.isEditable = false
            stackView.addArrangedSubview(text)
        }

        do {
            var string = AttributedString("Attributed string")
            string[AttributeScopes.AppKitAttributes.ForegroundColorAttribute.self] = .systemBlue

            let text = NSTextField()
            text.attributedStringValue = NSAttributedString(string)
            text.font = .systemFont(ofSize: 24)
            text.isEditable = false
            stackView.addArrangedSubview(text)
        }

        do {
            var string = AttributedString("Attributed string")
            string.foregroundColor = .systemTeal

            let text = NSTextField()
            text.attributedStringValue = NSAttributedString(string)
            text.font = .systemFont(ofSize: 24)
            text.isEditable = false
            stackView.addArrangedSubview(text)
        }

        do {
            var string = AttributedString("Attributed string")
            let range = string.range(of: "Attributed")!
            string[range].foregroundColor = .systemTeal

            let text = NSTextField()
            text.attributedStringValue = NSAttributedString(string)
            text.font = .systemFont(ofSize: 24)
            text.isEditable = false
            stackView.addArrangedSubview(text)
        }

        do {
            let attributedString = try! AttributedString(
                markdown:"**Markdown** [google](https://google.com)"
            )

            let text = NSTextField()
            text.attributedStringValue = NSAttributedString(attributedString)
            text.font = .systemFont(ofSize: 24)
            text.isEditable = false
            stackView.addArrangedSubview(text)
        }

        do {
            var string = AttributedString("Attributed string")

            var container = AttributeContainer()
            container.appKit.foregroundColor = .systemTeal
            string.mergeAttributes(container)

            let text = NSTextField()
            text.attributedStringValue = NSAttributedString(string)
            text.font = .systemFont(ofSize: 24)
            text.isEditable = false
            stackView.addArrangedSubview(text)
        }

        do {
            var string = AttributedString("Colorize punctuation!!!")
            let characterView = string.characters

            for i in characterView.indices where characterView[i].isPunctuation {
                let next = characterView.index(after: i)
                string[i..<next].foregroundColor = .systemBlue
            }

            let text = NSTextField()
            text.attributedStringValue = NSAttributedString(string)
            text.font = .systemFont(ofSize: 24)
            text.isEditable = false
            stackView.addArrangedSubview(text)
        }
    }

}
