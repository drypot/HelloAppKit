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

        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        view.addSubview(label)

        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)
        view.addSubview(slider)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEditable = true
        textField.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)
        view.addSubview(textField)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),

            slider.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            slider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            slider.widthAnchor.constraint(equalToConstant: 200),

            textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            textField.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8),
            textField.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
        ])
    }

}
