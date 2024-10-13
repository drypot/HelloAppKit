//
//  StackerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/23/24.
//

import AppKit

class AddStackDemoRunner: SubRunner {
}

class AddStackDemoController: NSViewController {

    override func loadView() {
        self.view = NSView()

        let constraints = ConstraintBuilder()

        addStackView(to: view) { stackView in
            stackView.orientation = .vertical
            constraints.stickEdges(of: stackView, to: view)
            
            addStackView(to: stackView) { stackView in
                stackView.orientation = .vertical

                let button1 = NSButton(title: "Button 1", target: nil, action: nil)
                stackView.addArrangedSubview(button1)
                
                let button2 = NSButton(title: "Button 2", target: nil, action: nil)
                stackView.addArrangedSubview(button2)

                let button3 = NSButton(title: "Button 3", target: nil, action: nil)
                stackView.addArrangedSubview(button3)
            }
            
            addStackView(to: stackView) { stackView in
                let button4 = NSButton(title: "Button 4", target: nil, action: nil)
                stackView.addArrangedSubview(button4)
                
                let button5 = NSButton(title: "Button 5", target: nil, action: nil)
                stackView.addArrangedSubview(button5)

                let button6 = NSButton(title: "Button 6", target: nil, action: nil)
                stackView.addArrangedSubview(button6)
            }
        }

        constraints.activate()
    }
    
}
