//
//  TextKit2Demo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/31/25.
//

import Cocoa

// TextKit
// https://developer.apple.com/documentation/appkit/textkit

// Meet TextKit 2
// https://developer.apple.com/videos/play/wwdc2021/10061/

class TextKit2Demo: NSViewController {

    private var contentStorage: NSTextContentStorage!
    private var layoutManager: NSTextLayoutManager!
    private var textContainer: NSTextContainer!
    private var textView: NSTextView!

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        view.addSubview(scrollView)

        contentStorage = NSTextContentStorage()

        textContainer = NSTextContainer()

        layoutManager = NSTextLayoutManager()
        layoutManager.textContainer = textContainer
        contentStorage.addTextLayoutManager(layoutManager)

        textView = NSTextView(frame: .zero, textContainer: textContainer)
        textView.isEditable = true
        textView.isRichText = false
        textView.font = .monospacedSystemFont(ofSize: 14, weight: .regular)

        // maxSize 설정하고, isVerticallyResizable = true 해야 세로스크롤 할 수 있었다.
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false  // wrap 하려면 false
        textView.textContainer?.widthTracksTextView = true  // wrap 하려면 true
        textView.autoresizingMask = [.width, .height]

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

//    override func viewDidLayout() {
//        print("\(textContainer.size)")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let docURL = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
            do {
                try contentStorage.textStorage?.read(from: docURL, documentAttributes: nil, error: ())
            } catch {
                // Could not read menu content.
            }
        }
    }
}
