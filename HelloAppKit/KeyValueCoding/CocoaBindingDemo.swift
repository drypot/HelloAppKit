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

    override func loadView() {
        let view = NSView()
        self.view = view

        objectController.bind(.content, to: self, withKeyPath: "person", options: nil)

        let nameField = NSTextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholderString = "Enter name"
        nameField.bind(.value, to: objectController, withKeyPath: "content.name", options: nil)
        view.addSubview(nameField)

        let nameLabel = NSTextField()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.isBezeled = false
        nameLabel.isEditable = false
        nameLabel.isSelectable = false
        nameLabel.backgroundColor = .clear
        nameLabel.bind(.value, to: objectController, withKeyPath: "content.name", options: nil)
        view.addSubview(nameLabel)

        let ageField = NSTextField()
        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.bind(.value, to: objectController, withKeyPath: "content.age", options: nil)
        view.addSubview(ageField)

        let ageLabel = NSTextField()
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.isBezeled = false
        ageLabel.isEditable = false
        ageLabel.isSelectable = false
        ageLabel.backgroundColor = .clear
        ageLabel.bind(.value, to: objectController, withKeyPath: "content.age", options: nil)
        view.addSubview(ageLabel)

        let resetButton = NSButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.title = "Reset"
        resetButton.bezelStyle = .rounded
        resetButton.action = #selector(resetAction)
        resetButton.target = self
        view.addSubview(resetButton)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            nameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameField.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),

            ageField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ageField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ageField.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),

            ageLabel.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 8),
            ageLabel.leadingAnchor.constraint(equalTo: ageField.leadingAnchor),

            resetButton.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 8),
            resetButton.leadingAnchor.constraint(equalTo: ageLabel.leadingAnchor),
        ])
    }

    @objc private func resetAction() {
        objectController.content = Person(name: "John Doe", age: 30)
    }

}
