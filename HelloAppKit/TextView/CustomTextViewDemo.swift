//
//  CustomTextViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/24/24.
//


import AppKit

// Mastering macOS programming-Packt Publishing (2017), 209p

// 커서가 워프하는 등, 먼가 버그 스럽게 동작하는데, 일단 대강 구경만 하는 것으로.

class CustomTextViewDemoRunner: SubRunner {
}

class CustomTextViewDemoController: EasyStackController {
    
    var customTextStorage: CustomTextStorage?
    
    override func addSubviews(to stackView: NSStackView) {
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
