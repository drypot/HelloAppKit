//
//  NSEditorDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/13/25.
//

import Cocoa

// 만들다 말았다.
// TextField 에 내용 입력하고 Tab 키를 한번 쳐줘야 변경된 내용이 ObjectController 에 반영된다.
// 나중에 쓸 일 있을 때 공부 다시 하고 만들어야;

class NSEditorDemo: NSViewController {

    let editorController = EditorController()
    let stackView = NSStackView()
    let textField = NSTextField()
    let doNothingButton = NSButton()
    let saveButton = NSButton()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupStackView()
        setupStackItems()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    private func setupStackItems() {
        textField.bind(.value, to: editorController, withKeyPath: "text", options: nil)
        stackView.addArrangedSubview(textField)

        doNothingButton.title = "DoNothing"
        stackView.addArrangedSubview(doNothingButton)

        saveButton.title = "Save"
        saveButton.target = self
        saveButton.action = #selector(saveDocument)
        stackView.addArrangedSubview(saveButton)
    }

    @objc func saveDocument() {
        do {
            try editorController.commitEditingWithoutPresentingError()
            print("Saved text: \(editorController.text)")
        } catch {
            print("Failed to commit edits: \(error)")
        }
    }

    // NSObjectController 는 NSController 를 계승하고
    // NSController 는 이미 NSEditor 를 프로토콜로 갖는다.

    class EditorController: NSObjectController /*, NSEditor */ {

        @objc dynamic var text: String = "" {
            didSet {
                print("text changed: \(text)")
                hasUnsavedChanges = true
            }
        }

        private var hasUnsavedChanges = false

        // NSEditor methods

        override func commitEditing() -> Bool {
            if hasUnsavedChanges {
                print("Committing edits: \(text)")
                hasUnsavedChanges = false
                return true
            }
            return false
        }

        override func commitEditingWithoutPresentingError() throws {
            if hasUnsavedChanges {
                print("Committing edits with error handling: \(text)")
                hasUnsavedChanges = false
            }
//            throw NSError(domain: "TextEditorError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No changes to commit"])
        }

        override func discardEditing() {
            print("Discarding edits...")
            hasUnsavedChanges = false
        }
    }
}
