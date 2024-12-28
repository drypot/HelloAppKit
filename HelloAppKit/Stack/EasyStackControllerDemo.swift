//
//  EasyStackControllerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 10/4/24.
//

import AppKit

class EasyStackControllerDemoRunner: SubRunner {
}

class EasyStackControllerDemoController: EasyStackController {

    override func addStckItems(_ stackView: NSStackView) {
        stackView.distribution = .fillEqually
        do {
            let textView = NSTextView()
            textView.string = "Hello, World!"
            textView.font = NSFont(name: "Helvetica", size: 24.0)
            stackView.addArrangedSubview(textView)
        }
        do {
            let textView = NSTextView()
            textView.string = "It's a good day for coding."
            textView.font = NSFont(name: "Helvetica", size: 24.0)
            stackView.addArrangedSubview(textView)
        }
    }

    override func viewDidLoad() {
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            ]
        )
    }
    
}
