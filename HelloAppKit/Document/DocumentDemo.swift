//
//  DocumentDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/23/24.
//

import AppKit
import UniformTypeIdentifiers

class DocumentDemoController: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        addStackItems(stackView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func addStackItems(_ stackView: NSStackView) {
        let button1 = NSButton(title: "New TextDocument", target: self, action: #selector(button1Clicked))
        stackView.addArrangedSubview(button1)

//        let button2 = NSButton(title: "Open JsonDocument", target: self, action: #selector(button2Clicked))
//        stackView.addArrangedSubview(button2)
//
//        let button3 = NSButton(title: "Button 3", target: self, action: #selector(button3Clicked))
//        stackView.addArrangedSubview(button3)
    }

    @objc func button1Clicked(_ sender: NSButton) {
        let docController = NSDocumentController.shared

        print("button1Clicked")

        print("docController.documentClassNames: \(docController.documentClassNames)") // ["HelloAppKit.TextDocument"]
        print("docController.defaultType: \(docController.defaultType!)")
        print("docController.documentClassForType: \(docController.documentClass(forType: UTType.plainText.identifier)!)")
        print("docController.displayNameForType: \(docController.displayName(forType: UTType.plainText.identifier)!)")

        print("TextDocument.readableTypes: \(TextDocument.readableTypes)")

        // https://developer.apple.com/documentation/appkit/nsdocumentcontroller/makeuntitleddocument(oftype:)

//        let document = TextDocument()
        guard let document = try? docController.makeUntitledDocument(ofType: UTType.plainText.identifier) as? TextDocument else {
            print("makeUntitledDocument failed")
            return
        }

        docController.addDocument(document)
        document.makeWindowControllers()
        document.showWindows()

        //let sampleString = "In an age of endless noise and fleeting moments, the rarest treasures are found in the quiet places where we reconnect with ourselves."
        let sampleString = ""
        document.setContent(sampleString)
    }

    @objc func button2Clicked(_ sender: NSButton) {
        print("button2 clicked")
    }

    @objc func button3Clicked(_ sender: NSButton) {
        print("button3 clicked")
    }

}
