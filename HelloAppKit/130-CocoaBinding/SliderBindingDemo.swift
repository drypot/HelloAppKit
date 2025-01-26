//
//  SliderBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/27/25.
//

import AppKit

class SliderBindingDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let targetActionDemo = TargetActionDemo()
        let keyValueBindingDemo = KeyValueBindingDemo()

        addChild(targetActionDemo)
        addChild(keyValueBindingDemo)

        let stackView = NSStackView(views: [
            targetActionDemo.view,
            keyValueBindingDemo.view
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.spacing = 10

        view.addSubview(stackView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
//            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
//            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
//            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    class TargetActionDemo: NSViewController {
        let slider = NSSlider(value: 50.0, minValue: 0.0, maxValue: 100.0, target: nil, action: nil)
        let textField = NSTextField(string: "50.0")

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false

            // slider.target 에 textField 를
            // slider.action 에 #selector(textField.takeFloatValueFrom) 을 바로 연결해도 동작한다.
            // 좀 일반화를 위해서 일단 action 을 컨트롤러 메서드에 연결하는 방식을 그대로 뒀다.

            slider.target = self
            slider.action = #selector(sliderValueChanged)

            textField.isEditable = true
            textField.target = self
            textField.action = #selector(textFieldValueChanged)

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
//                stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
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

    class KeyValueBindingDemo: NSViewController {

        @objc dynamic var sliderValue = 50.0

        let slider = NSSlider(value: 50.0, minValue: 0.0, maxValue: 100.0, target: nil, action: nil)
        let textField = NSTextField(string: "50.0")

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false

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
//                stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            ])

            // Bind the slider's value to `sliderValue`
            slider.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)

            // Bind the text field's value to `sliderValue`
            textField.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)
        }
    }

}
