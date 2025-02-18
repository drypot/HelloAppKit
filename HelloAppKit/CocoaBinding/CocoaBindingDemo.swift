//
//  CocoaBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/26/25.
//

import AppKit

class CocoaBindingDemo: NSViewController {

    class Person: NSObject {
        @objc dynamic var name: String
        @objc dynamic var age: Int

        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }

    @objc var person = Person(name: "John Doe", age: 30)
    var objectController = NSObjectController()

    let stackView = NSStackView()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupStackView()
        setupStackItems()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
//            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
//            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        objectController.bind(.content, to: self, withKeyPath: "person", options: nil)

        let nameField = NSTextField()
//        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholderString = "Enter name"
        nameField.bind(.value, to: objectController, withKeyPath: "content.name", options: nil)

        let nameLabel = NSTextField()
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.isBezeled = false
        nameLabel.isEditable = false
        nameLabel.isSelectable = false
        nameLabel.backgroundColor = .clear
        nameLabel.bind(.value, to: objectController, withKeyPath: "content.name", options: nil)

        let ageField = NSTextField()
//        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.bind(.value, to: objectController, withKeyPath: "content.age", options: nil)

        let ageLabel = NSTextField()
        //        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.isBezeled = false
        ageLabel.isEditable = false
        ageLabel.isSelectable = false
        ageLabel.backgroundColor = .clear
        ageLabel.bind(.value, to: objectController, withKeyPath: "content.age", options: nil)

        let resetButton = NSButton()
//        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.title = "Reset"
        resetButton.bezelStyle = .rounded
        resetButton.action = #selector(resetAction)
        resetButton.target = self

        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(ageField)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(resetButton)
    }

    @objc private func resetAction() {
        objectController.content = Person(name: "John Doe", age: 30)
    }

}
