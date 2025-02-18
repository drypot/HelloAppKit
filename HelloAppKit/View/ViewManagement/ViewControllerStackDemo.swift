//
//  SliderBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/27/25.
//

import AppKit

class ViewControllerStackDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let controller1 = Controller1()
        let controller2 = Controller2()

        addChild(controller1)
        addChild(controller2)

        let stackView = NSStackView(views: [
            controller1.view,
            controller2.view
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.spacing = 10

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
//            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
//            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    class Controller1: NSViewController {
        let label = NSTextField(labelWithString: "Controller1")

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false

            let stackView = NSStackView(views: [label])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.orientation = .vertical
            stackView.spacing = 10

            view.addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
//                stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            ])
        }
    }

    class Controller2: NSViewController {

        let label = NSTextField(labelWithString: "Controller2")

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false

            let stackView = NSStackView(views: [label])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.orientation = .vertical
            stackView.spacing = 10

            view.addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
//                stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            ])
        }
    }

}
