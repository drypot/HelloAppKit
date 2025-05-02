//
//  TextDocument.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/30/24.
//

import AppKit

// Developing a Document-Based App
// https://developer.apple.com/documentation/appkit/developing-a-document-based-app

// Model과 View를 CocoaBinding으로 다이나믹하게 엮어 쓰는 문화가 있어서;
// 모델 클래스는 Objective-C 클래스여야 원만하고,
// 프로퍼티는 @objc dynamic 이어야 한다,

class TextDocumentModel: NSObject {

    @objc dynamic var text: String

    public init(text: String = "") {
        self.text = text
    }

}

class TextDocument: NSDocument {

    @objc var model = TextDocumentModel()

    var viewController: TextDocumentViewController!

    override init() {
        super.init()
    }

    // MARK: - Enablers

    // This enables auto save.
    override class var autosavesInPlace: Bool {
        return true
    }

    // 아래 async 옵션 켜면 크래쉬가 난다.
    // 무슨 일인지 다음에 해결해야.

//    // This enables asynchronous-writing.
//    override func canAsynchronouslyWrite(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) -> Bool {
//        return true
//    }
//
//    // This enables asynchronous reading.
//    override class func canConcurrentlyReadDocuments(ofType: String) -> Bool {
//        return ofType == "public.plain-text"
//    }

    // MARK: - User Interface

    override func makeWindowControllers() {
        let windowController = TextDocumentWindowController()
        self.addWindowController(windowController)

        viewController = windowController.contentViewController as? TextDocumentViewController
        viewController.representedObject = self
    }

    // MARK: - Reading and Writing

    override func data(ofType typeName: String) throws -> Data {
        return model.text.data(using: .utf8)!
//        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    // You should disable undo registration during document reading.

    override func read(from data: Data, ofType typeName: String) throws {
        guard let text = String(data: data, encoding: .utf8) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        Task {
            await MainActor.run {
                model.text = text
                viewController.updateView()
            }
        }
    }

    func setText(_ text: String) {
        model.text = text
        viewController.updateView()
    }
}

class TextDocumentWindowController: NSWindowController, NSWindowDelegate {

    init() {
        // window 는 windowController 가 retain 하므로 따로 retain 하지 않아도 된다.
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        super.init(window: window)

        window.title = "Text Document"
        window.center()

        // windowController.contentViewController -> 는
        // window.contentView -> 를 가리킨다고 공식 문서에 나와 있는데
        // window.contentViewController 의 오타 아닐까;

        // window.contentViewController 를 세팅하면
        // window.contentView 는 contentViewController.view 로 자동 설정된다.

        window.contentViewController = TextDocumentViewController()

        window.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // NSWindowDelegate methods

    func windowWillClose(_ notification: Notification) {
        print("window will close")
    }
}

class TextDocumentViewController: NSViewController, NSTextViewDelegate {

    private let textView = NSTextView()

    override var representedObject: Any? {
        didSet {
//            for child in children {
//                child.representedObject = representedObject
//            }
            updateView()
        }
    }

    var document: TextDocument {
        guard let document = representedObject as? TextDocument else {
            fatalError()
        }
        return document
    }

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        view.addSubview(scrollView)

//      NSTextView 자체는 Auto Layout을 사용하기보다는
//      autoresizingMask로 크기를 따라가도록 구성하는 것이 일반적이라고 한다.

        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.autoresizingMask = [.width, .height]
        textView.font = NSFont.systemFont(ofSize: 24.0)
        textView.delegate = self

        scrollView.documentView = textView

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
    }

    func updateView() {
        textView.string = document.model.text
    }

    // MARK: - NSTextViewDelegate

//  아래 코드는 의미를 아직 잘 모르니, 일단 코멘트 아웃.

//    func textDidBeginEditing(_ notification: Notification) {
//        document.objectDidBeginEditing(self)
//    }
//
//    func textDidEndEditing(_ notification: Notification) {
//        document.objectDidEndEditing(self)
//    }

}
