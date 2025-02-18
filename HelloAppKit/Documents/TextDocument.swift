//
//  TextDocument.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/30/24.
//

import AppKit

// The Cocoa document architecture uses the Objective-C runtime

// Plain Text 용 Info.plist 세팅,
//
// Name: Plain Text Doucment      // Save As dialog 의 팝업 메뉴에 사용된다.
// Identifier: public.plain-text
// Class: $(PRODUCT_MODULE_NAME).TextDocument
//
// 나머지는 적당히
// Class 프리픽스로 $(PRODUCT_MODULE_NAME) 안 달아주니 클래스를 찾지 못한다.

class TextDocument: NSDocument {

//    nonisolated(unsafe) var content: String = ""

//    override init() {
//        super.init()
//    }

    var viewController : TextDocumentViewController!

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Text Document"
        window.center()

        // window.contentViewController 를 세팅하면
        // window.contentView 는 contentViewController.view 로 자동 설정된다고 한다.

        viewController = TextDocumentViewController()
        viewController.representedObject = self

        window.contentViewController = viewController

        // windowController.contentViewController 대신
        // window.contentViewController 를 설정하면 된다는 것 같다.

        let windowController = NSWindowController(window: window)
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        let content = self.viewController.textView.string
        guard let data = content.data(using: .utf8) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        return data
    }

    // You should disable undo registration during document reading.

    override func read(from data: Data, ofType typeName: String) throws {
        guard let content = String(data: data, encoding: .utf8) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        Task {
            await MainActor.run {
                setContent(content)
            }
        }
    }

    @MainActor
    func setContent(_ content: String) {
        self.viewController.textView.string = content
    }
}

