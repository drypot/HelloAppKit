//
//  GestureRecognizerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class GestureRecognizerDemoRunner: SubRunner {
}

class GestureRecognizerDemoController: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        addStckItems(stackView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            //stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            //stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            //stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func addStckItems(_ stackView: NSStackView) {
        let childView1 = NSView()
        childView1.translatesAutoresizingMaskIntoConstraints = false
        childView1.wantsLayer = true
        childView1.layer?.backgroundColor = NSColor.red.cgColor
        stackView.addArrangedSubview(childView1)

        let clickGestureRecognizer = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        childView1.addGestureRecognizer(clickGestureRecognizer)
    }

    @objc func handleClick(_ sender: NSClickGestureRecognizer) {
        let locationInView = sender.location(in: sender.view)
        print("Mouse clicked at: \(locationInView)")
    }

}
