//
//  TextDocument.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/30/24.
//

import AppKit

// The Cocoa document architecture uses the Objective-C runtime

class TextDocument: NSDocument {

    nonisolated(unsafe) var content: String = ""

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        let viewController = TextDocumentViewController()
        viewController.document = self
        viewController.representedObject = self

        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Text Document"
        window.center()

        // contentViewController 를 세팅하면
        // contentView 는 contentViewController.view 로 자동 설정된다고 한다.

        window.contentViewController = viewController

        // windowController.contentViewController 대신
        // window.contentViewController 를 설정하면 된다는 것 같다.

        let windowController = NSWindowController(window: window)
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        guard let data = content.data(using: .utf8) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        return data
    }

    // You should disable undo registration during document reading.

//    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
//    }

    override func read(from data: Data, ofType typeName: String) throws {
        guard let content = String(data: data, encoding: .utf8) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        self.content = content
    }

}

