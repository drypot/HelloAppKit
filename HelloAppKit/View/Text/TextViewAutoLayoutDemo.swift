//
//  TextViewAutoLayoutDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import AppKit

// 삭제 대상;

class TextViewAutoLayoutDemo: NSViewController, NSTextViewDelegate {

    private var textView: NSTextView!

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("TextViewAutoLayoutDemo")

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        view.addSubview(scrollView)

        textView = NSTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.isVerticallyResizable = true
//        textView.isHorizontallyResizable = true
//        textView.textContainer?.size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = true
        textView.textContainer?.heightTracksTextView = true
//        textView.delegate = self

//        // maxSize 설정을 해야 세로스크롤 할 수 있었다.
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)

        scrollView.documentView = textView

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),

            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])

//        heightConstraint = textView.heightAnchor.constraint(equalToConstant: 30)
//        heightConstraint.isActive = true

        if let url = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
            do {
                try textView.textStorage?.read(from: url, documentAttributes: nil, error: ())
            } catch {
                // Could not read menu content.
            }
        }

        print("\(textView.textContainer?.size)")
        print("\(textView.frame)")

    }

    // NSTextViewDelegate

    func textDidChange(_ notification: Notification) {
        adjustTextViewHeight()
    }

    private func adjustTextViewHeight() {
//        guard let layoutManager = textView.layoutManager else { return }
//        guard let textContainer = textView.textContainer else { return }
//
//        layoutManager.ensureLayout(for: textContainer)
//        let size = layoutManager.usedRect(for: textContainer).size
//        heightConstraint.constant = size.height
    }

}
