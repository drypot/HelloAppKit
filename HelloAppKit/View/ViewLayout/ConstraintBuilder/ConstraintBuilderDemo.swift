//
//  ConstraintBuilderDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import AppKit

class ConstraintBuilderDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        view.addSubview(stackView)

        addStackItems(stackView)

        let constraints = ConstraintBuilder()
        constraints.stickEdges(of: stackView, to: view)
        constraints.setMinSize(of: stackView, width: 400, height: 400)
        constraints.activate()
    }

    func addStackItems(_ stackView: NSStackView) {
        do {
            let button = NSButton(title: "Button 1", target: nil, action: nil)
            stackView.addArrangedSubview(button)
        }

        do {
            let button = NSButton(title: "Button 2", target: nil, action: nil)
            stackView.addArrangedSubview(button)
        }

        do {
            let button = NSButton(title: "Button 3", target: nil, action: nil)
            stackView.addArrangedSubview(button)
        }
    }

}
