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

    let textField = NSTextField()
    let doNothingButton = NSButton()
    let saveButton = NSButton()

    override func loadView() {
        let view = NSView()
        self.view = view

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.bind(.value, to: editorController, withKeyPath: "text", options: nil)
        view.addSubview(textField)

        doNothingButton.title = "DoNothing"
        doNothingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doNothingButton)

        saveButton.title = "Save"
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.target = self
        saveButton.action = #selector(saveDocument)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),

            doNothingButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            doNothingButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),

            saveButton.topAnchor.constraint(equalTo: doNothingButton.bottomAnchor, constant: 8),
            saveButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
        ])
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
