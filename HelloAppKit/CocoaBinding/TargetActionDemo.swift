//
//  SliderBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/27/25.
//

import AppKit

class TargetActionDemo: NSViewController {

    let label = NSTextField(labelWithString: "Target Action")
    let slider = NSSlider(value: 50.0, minValue: 0.0, maxValue: 100.0, target: nil, action: nil)
    let textField = NSTextField(string: "50.0")

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        // target: The object that should respond to the event.
        // action: The method (selector) that gets called on the target when the event occurs.

        // slider.target 에 textField 를
        // slider.action 에 #selector(textField.takeFloatValueFrom) 을 바로 연결해도 동작한다.
        // 일반적인 경우를 위해 controller를 target으로 하는 방식을 썼다.

        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        view.addSubview(label)

        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.target = self
        slider.action = #selector(sliderValueChanged)
        view.addSubview(slider)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEditable = true
        textField.target = self
        textField.action = #selector(textFieldValueChanged)
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

    @objc func sliderValueChanged(_ sender: NSSlider) {
        // Update the text field to reflect the slider value
        textField.takeFloatValueFrom(sender)
    }

    @objc func textFieldValueChanged(_ sender: NSTextField) {
        // Update the slider to reflect the text field value
        slider.takeFloatValueFrom(sender)
    }

}
