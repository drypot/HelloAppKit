//
//  PopOverDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/30/25.
//

import Cocoa

class PopOverDemo: NSViewController {

    var displayLabel: NSTextField!

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        displayLabel = NSTextField(labelWithString: "Click here")
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.isEditable = false
        displayLabel.isBordered = false
        displayLabel.drawsBackground = false
        displayLabel.font = .preferredFont(forTextStyle: .title1)
        view.addSubview(displayLabel)

        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(clickAction))
        displayLabel.addGestureRecognizer(clickGesture)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            displayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

    }

    @objc func clickAction(_ sender: NSClickGestureRecognizer) {
        guard let viewToAttach = displayLabel else { return }

//        if let presented = self.presentedViewControllers, !presented.isEmpty {
//            return
//        }

        let popoverVC = NSViewController()
        popoverVC.view = NSView()
        popoverVC.preferredContentSize = NSSize(width: 300, height: 50)

        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholderString = "Enter text"
        textField.target = self
        textField.action = #selector(textFieldAction(_:))
        popoverVC.view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: popoverVC.view.topAnchor, constant: 10),
            textField.bottomAnchor.constraint(equalTo: popoverVC.view.bottomAnchor, constant: -10),
            textField.leadingAnchor.constraint(equalTo: popoverVC.view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: popoverVC.view.trailingAnchor, constant: -10)
        ])

        self.present(
            popoverVC,
            asPopoverRelativeTo: viewToAttach.bounds,
            of: viewToAttach,
            preferredEdge: .maxY,
            behavior: .transient)  // .transient: 외부 클릭 시 자동 닫힘

        // popover가 표시된 후 텍스트필드에 포커스 주기
        DispatchQueue.main.async {
            textField.becomeFirstResponder()
        }
    }

    @objc func textFieldAction(_ sender: NSTextField) {
        displayLabel.stringValue = sender.stringValue
        if let presentedVC = self.presentedViewControllers?.first {
            self.dismiss(presentedVC)
        }
    }
}
