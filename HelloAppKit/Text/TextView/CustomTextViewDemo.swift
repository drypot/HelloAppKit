//
//  CustomTextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/24/24.
//


import AppKit

// Mastering macOS programming-Packt Publishing (2017), 209p

// 커서가 워프하는 등, 먼가 버그 스럽게 동작하는데, 일단 대강 구경만 하는 것으로.

class CustomTextViewDemo: NSViewController {

    var customTextStorage: CustomTextStorage?

    override func loadView() {
        let view = NSView()
        self.view = view

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
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
        let container = NSTextContainer()
        container.widthTracksTextView = true

        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(container)

        let customTextStorage = CustomTextStorage()
        self.customTextStorage = customTextStorage
        let attrString = NSAttributedString(
            string: "Type some colors here...",
            attributes: [.foregroundColor: NSColor.darkGray]
        )
        customTextStorage.append(attrString)
        customTextStorage.addLayoutManager(layoutManager)

        let textView = NSTextView(frame: .zero, textContainer: container)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = NSFont.systemFont(ofSize: 24)
        textView.delegate = self
        stackView.addArrangedSubview(textView)
    }

}

extension CustomTextViewDemo: NSTextViewDelegate {

}
