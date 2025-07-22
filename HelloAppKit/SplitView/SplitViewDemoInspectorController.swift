//
//  SplitViewDemoInspectorController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 5/3/25.
//

import Cocoa

class SplitViewDemoInspectorController: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let label = NSTextField(labelWithString: "Inspector")
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

}
