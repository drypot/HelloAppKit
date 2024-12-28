//
//  CustomTextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/24/24.
//


import AppKit

// Mastering macOS programming-Packt Publishing (2017), 209p

// 커서가 워프하는 등, 먼가 버그 스럽게 동작하는데, 일단 대강 구경만 하는 것으로.

class CustomTextViewDemoController: NSViewController {

    var customTextStorage: CustomTextStorage?

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        addStackItems(stackView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            //stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            //stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            //stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
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
        textView.font = NSFont.systemFont(ofSize: 24)
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(textView)
    }
        
}

extension CustomTextViewDemoController: NSTextViewDelegate {
    
}
