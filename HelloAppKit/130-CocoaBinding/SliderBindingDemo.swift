//
//  SliderBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/27/25.
//

import AppKit

class SliderBindingDemo: NSViewController {

    let slider = NSSlider(value: 50.0, minValue: 0.0, maxValue: 100.0, target: nil, action: nil)
    let textField = NSTextField(string: "50.0")

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        slider.target = self
        slider.action = #selector(sliderValueChanged)

        textField.isEditable = true
        textField.action = #selector(textFieldValueChanged)
        textField.target = self

        let stackView = NSStackView(views: [slider, textField])
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
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    @objc func sliderValueChanged(_ sender: NSSlider) {
        // Update the text field to reflect the slider value
        textField.takeFloatValueFrom(sender)
    }

    @objc func textFieldValueChanged(_ sender: NSTextField) {
        // Update the slider to reflect the text field value
        slider.takeFloatValueFrom(sender)
    }
}
