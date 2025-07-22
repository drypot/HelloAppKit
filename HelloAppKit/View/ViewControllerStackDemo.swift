//
//  SliderBindingDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/27/25.
//

import AppKit

class ViewControllerStackDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let controller1 = Controller1()
        let controller2 = Controller2()

        let childView1 = controller1.view
        let childView2 = controller2.view

        view.addSubview(childView1)
        view.addSubview(childView2)

        addChild(controller1)
        addChild(controller2)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            childView1.topAnchor.constraint(equalTo: view.topAnchor),
            childView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            childView1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),

            childView2.topAnchor.constraint(equalTo: view.topAnchor),
            childView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childView2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            childView2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    class Controller1: NSViewController {
        override func loadView() {
            let view = NSView()
        self.view = view
            view.translatesAutoresizingMaskIntoConstraints = false
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.red.cgColor
        }
    }

    class Controller2: NSViewController {
        override func loadView() {
            let view = NSView()
            self.view = view
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.blue.cgColor
        }
    }

}
