//
//  TextDocument.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/30/24.
//

import AppKit

// The Cocoa document architecture uses the Objective-C runtime

// Properties should be declared dynamic in Swift,
// which tells the compiler to use dynamic dispatch to access that attribute.

class TextData: NSObject {

    @objc dynamic var content = ""

    public init(content: String) {
        self.content = content
    }

}

class TextDocument: NSDocument {

    nonisolated(unsafe) var content: String = ""

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        let viewController = TextViewController()
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

    override func read(from data: Data, ofType typeName: String) throws {
        guard let content = String(data: data, encoding: .utf8) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        self.content = content
    }

}

class TextViewController: NSViewController {
    weak var document: TextDocument?
    private var textView = NSTextView()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = NSFont.systemFont(ofSize: 24.0)

        //        NSLayoutConstraint.activate([
        //            textView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400)
        //        ])

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.documentView = textView

        view.addSubview(scrollView)

        let padding = 20.0
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let document else { return }
        textView.string = document.content
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        guard let document else { return }
        document.content = textView.string
    }
}
