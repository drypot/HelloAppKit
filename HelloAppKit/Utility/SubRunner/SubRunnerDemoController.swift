//
//  SubRunnerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/27/24.
//

import AppKit

class SubRunnerDemo: NSViewController {

    var subRunnerTypes = [String: SubRunner.Type]()

    let stackView = NSStackView()

    override func loadView() {
        self.view = NSView()
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
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    private func setupStackItems() {
        var constraints: [NSLayoutConstraint] = []

        func addSubRunner(_ subRunnerType: SubRunner.Type) {
            let className = String(subRunnerType.className().split(separator: ".").last!)
            //print(className)
            let buttonTitle = className.dropSuffix("Runner").dropSuffix("Controller").dropSuffix("Demo")
            subRunnerTypes[buttonTitle] = subRunnerType
            addButton(buttonTitle)
        }
        
        func addButton(_ title: String) {
            let button: NSButton = NSButton(title: title, target: self, action: #selector(buttonClicked))
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            constraints.append(contentsOf: [
                button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            ])
        }

        addSubRunner(SubRunnerSample1Runner.self)
        addSubRunner(SubRunnerSample2Runner.self)

        //        subclasses(of: SubRunner.self)
        //            .filter {
        //                $0 != DemoListRunner.self
        //            }
        //            .sorted {
        //                $0.className() < $1.className()
        //            }
        //            .forEach(addSubRunner)

        NSLayoutConstraint.activate(constraints)
    }
        
    @objc func buttonClicked(_ sender: NSButton) {
        let subRunnerType = subRunnerTypes[sender.title]!
        subRunnerType.init().run()
    }

}

