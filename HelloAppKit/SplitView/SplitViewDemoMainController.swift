//
//  SplitViewDemoMainController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 5/3/25.
//

import Cocoa

class SplitViewDemoMainController: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor

        let label = NSTextField(labelWithString: "Main")
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            //  view.topAnchor 대신 view.safeAreaLayoutGuide.topAnchor 써야 label 이 천정에 붙지 않는다.
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

}
