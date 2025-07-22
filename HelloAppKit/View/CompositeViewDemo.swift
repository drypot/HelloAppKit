//
//  CompositeViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import Cocoa

class CompositeViewDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let childView = CompositeView()
        childView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            childView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    class CompositeView: NSView {

        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)

            let childView1 = NSView()
            childView1.translatesAutoresizingMaskIntoConstraints = false
            childView1.wantsLayer = true
            childView1.layer?.backgroundColor = NSColor.red.cgColor
            addSubview(childView1)

            let childView2 = NSView()
            childView2.translatesAutoresizingMaskIntoConstraints = false
            childView2.wantsLayer = true
            childView2.layer?.backgroundColor = NSColor.blue.cgColor
            addSubview(childView2)

            NSLayoutConstraint.activate([
                childView1.topAnchor.constraint(equalTo: self.topAnchor),
                childView1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                childView1.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                childView1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
                childView1.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),

                childView2.topAnchor.constraint(equalTo: self.topAnchor),
                childView2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                childView2.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                childView2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
            ])

            let clickGestureRecognizer = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
            self.addGestureRecognizer(clickGestureRecognizer)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        @objc func handleClick(_ sender: NSClickGestureRecognizer) {
            let locationInView = sender.location(in: self)
            print("clicked at: \(locationInView)")
        }
    }

}

