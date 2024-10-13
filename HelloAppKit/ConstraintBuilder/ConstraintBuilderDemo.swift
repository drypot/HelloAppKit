//
//  ConstraintBuilderDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import AppKit

class ConstraintBuilderDemoRunner: SubRunner {
}

class ConstraintBuilderDemoController: NSViewController {

    override func loadView() {
        self.view = NSView()

        let constraints = ConstraintBuilder()

        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        constraints.stickEdges(of: stackView, to: view)
        constraints.setMinSize(of: stackView, width: 600, height: 400)
        
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
        
        constraints.activate()
    }
    
}
