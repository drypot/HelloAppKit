//
//  ViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class CocoaBindingDemoController: NSViewController {

    @objc class Person: NSObject {
        @objc dynamic var name: String
        @objc dynamic var age: Int

        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }

    var objectController: NSObjectController!

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let childView = NSView()
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.wantsLayer = true
        view.addSubview(childView)

        let person = Person(name: "John Doe", age: 30)
        objectController = NSObjectController(content: person)

        let nameLabel = NSTextField()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.stringValue = "Name"
        nameLabel.isBezeled = false
        nameLabel.isEditable = false
        nameLabel.isSelectable = false
        nameLabel.backgroundColor = .clear

        let nameField = NSTextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholderString = "Enter value"

        nameField.bind(.value, to: objectController!, withKeyPath: "content.name", options: nil)

        let ageLabel = NSTextField()
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.stringValue = "Age"
        ageLabel.isBezeled = false
        ageLabel.isEditable = false
        ageLabel.isSelectable = false
        ageLabel.backgroundColor = .clear

        let ageField = NSTextField()
        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.bind(.value, to: objectController!, withKeyPath: "content.age", options: nil)

        let resetButton = NSButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.title = "Reset"
        resetButton.bezelStyle = .rounded
        resetButton.action = #selector(resetAction)
        resetButton.target = self

        childView.addSubview(nameLabel)
        childView.addSubview(nameField)
        childView.addSubview(ageLabel)
        childView.addSubview(ageField)
        childView.addSubview(resetButton)

        let padding = 20.0
        let interPadding = 8.0
        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            childView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            childView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            childView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            nameLabel.leadingAnchor.constraint(equalTo: childView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: childView.topAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 60),
//            nameLabel.heightAnchor.constraint(equalToConstant: 24),

            nameField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: interPadding),
            nameField.trailingAnchor.constraint(equalTo: childView.trailingAnchor),
            nameField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),

            ageLabel.leadingAnchor.constraint(equalTo: childView.leadingAnchor),
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: interPadding),
            ageLabel.widthAnchor.constraint(equalToConstant: 60),
//            ageLabel.heightAnchor.constraint(equalToConstant: 24),

            ageField.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: interPadding),
            ageField.trailingAnchor.constraint(equalTo: childView.trailingAnchor),
            ageField.centerYAnchor.constraint(equalTo: ageLabel.centerYAnchor),

            resetButton.leadingAnchor.constraint(equalTo: childView.leadingAnchor, constant: 60 + interPadding),
            resetButton.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: interPadding),
            resetButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc private func resetAction() {
        objectController.content = Person(name: "John Doe", age: 30)
    }

}
