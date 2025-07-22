//
//  ButtonDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/12/25.
//

import Cocoa

class ButtonDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])

        do {
            let button = NSButton(title: "Default", target: self, action: #selector(buttonAction))
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "bezelStyle: push", target: self, action: #selector(buttonAction))
            button.bezelStyle = .push
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "bezelStyle:\nFlexible Push", target: self, action: #selector(buttonAction))
            button.bezelStyle = .flexiblePush
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "bezelStyle: toolbar", target: self, action: #selector(buttonAction))
            button.bezelStyle = .toolbar
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "bezelStyle: accessoryBar", target: self, action: #selector(buttonAction))
            button.bezelStyle = .accessoryBar
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "bezelStyle: accessoryBarAction", target: self, action: #selector(buttonAction))
            button.bezelStyle = .accessoryBarAction
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "bezelStyle: badge", target: self, action: #selector(buttonAction))
            button.bezelStyle = .badge
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "controlSize: large", target: self, action: #selector(buttonAction))
            button.controlSize = .large
            stackView.addArrangedSubview(button)
        }
        do {
            // 심볼 이미지 크기에 따라 버큰 크기가 변경되지 않는다;
            // 버튼 리사이징하다가 포기;
            // 다음 기회에;
            let symbol = NSImage(systemSymbolName: "heart.fill", accessibilityDescription: "Heart")
            let config = NSImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
            let configured = symbol!.withSymbolConfiguration(config)
            let button = NSButton(image: configured!, target: self, action: #selector(buttonAction))
            button.bezelStyle = .toolbar
            stackView.addArrangedSubview(button)
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 48),
                button.heightAnchor.constraint(equalToConstant: 48),
            ])
        }
        do {
            let button = NSButton(title: "keyEquivalent: \\r", target: self, action: #selector(buttonAction))
            button.keyEquivalent = "\r"
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "type: toggle", target: self, action: #selector(buttonAction))
            button.setButtonType(.toggle)
            button.alternateTitle = "Pushed"
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(checkboxWithTitle: "check box", target: self, action: #selector(buttonAction))
            stackView.addArrangedSubview(button)
        }
        do {
            // 같은 action handler 를 사용하는 버튼들 끼리 자동으로 그루핑 된다고 한다.
            let options = ["Option 1", "Option 2", "Option 3"]
            for (index, title) in options.enumerated() {
                let button = NSButton(radioButtonWithTitle: title, target: self, action: #selector(buttonAction))
                if index == 0 {
                    button.state = .on
                }
                stackView.addArrangedSubview(button)
            }
        }

    }

    @objc func buttonAction(_ sender: NSButton) {
        print("button: \(sender.title)")
    }

}
