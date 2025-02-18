//
//  SliderBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/27/25.
//

import AppKit

class KeyValueBindingDemo: NSViewController {

    @objc dynamic var sliderValue = 50.0

    let stackView = NSStackView()

    let label = NSTextField(labelWithString: "Key Value Binding")
    let slider = NSSlider(value: 50.0, minValue: 0.0, maxValue: 100.0, target: nil, action: nil)
    let textField = NSTextField(string: "50.0")

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupStackView()
        setupStackItems()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        stackView.addArrangedSubview(label)

        // Bind the slider's value to `sliderValue`
        slider.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)
        stackView.addArrangedSubview(slider)

        // Bind the text field's value to `sliderValue`
        textField.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)
        stackView.addArrangedSubview(textField)
    }

}
