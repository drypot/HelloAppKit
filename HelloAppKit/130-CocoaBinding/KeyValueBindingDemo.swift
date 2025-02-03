//
//  SliderBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/27/25.
//

import AppKit

class KeyValueBindingDemo: NSViewController {

    @objc dynamic var sliderValue = 50.0

    let label = NSTextField(labelWithString: "Key Value Binding")
    let slider = NSSlider(value: 50.0, minValue: 0.0, maxValue: 100.0, target: nil, action: nil)
    let textField = NSTextField(string: "50.0")

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView(views: [label, slider, textField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.spacing = 10

        view.addSubview(stackView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
//            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])

        // Bind the slider's value to `sliderValue`
        slider.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)

        // Bind the text field's value to `sliderValue`
        textField.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)
    }

}
