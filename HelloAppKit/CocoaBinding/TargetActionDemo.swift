//
//  SliderBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/27/25.
//

import AppKit

class TargetActionDemo: NSViewController {

    let padding = 20.0

    let stackView = NSStackView()

    let label = NSTextField(labelWithString: "Target Action")
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
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        // target: The object that should respond to the event.
        // action: The method (selector) that gets called on the target when the event occurs.

        // slider.target 에 textField 를
        // slider.action 에 #selector(textField.takeFloatValueFrom) 을 바로 연결해도 동작한다.
        // 일반적인 경우를 위해 controller를 target으로 하는 방식을 썼다.

        stackView.addArrangedSubview(label)

        slider.target = self
        slider.action = #selector(sliderValueChanged)
        stackView.addArrangedSubview(slider)

        textField.isEditable = true
        textField.target = self
        textField.action = #selector(textFieldValueChanged)
        stackView.addArrangedSubview(textField)
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
