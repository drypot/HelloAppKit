//
//  TextStorageToggleWrapDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/21/25.
//

import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

// Putting an NSTextView Object in an NSScrollView
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextUILayer/Tasks/TextInScrollView.html#//apple_ref/doc/uid/20000938

class TextStorageToggleWrapDemo: NSViewController {

    // textStorage 외에는 로컬 변수에 잠시 담아 써도 되는데
    // 이런 저런 메서드에서 사용할 상황을 대비해 인스턴스 변수로 뽑아놨다.

    private var textStorage: NSTextStorage!
    private var layoutManager: NSLayoutManager!
    private var textContainer: NSTextContainer!
    private var textView: NSTextView!

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonBar = NSStackView()
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.orientation = .horizontal
        view.addSubview(buttonBar)

        let wrapButton = NSButton(title: "Wrap", target: self, action: #selector(wrapAction))
        wrapButton.setButtonType(.pushOnPushOff)
        wrapButton.controlSize = .large
        wrapButton.bezelStyle = .toolbar
        wrapButton.state = .on
        buttonBar.addArrangedSubview(wrapButton)

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false  // wrap 하려면 false
        view.addSubview(scrollView)

        // NSTextStorage
        textStorage = NSTextStorage()
        if let url = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
            do {
                try textStorage.read(from: url, documentAttributes: nil, error: ())
            } catch {
                // Could not read menu content.
            }
        }

        // NSLayoutManager
        layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        // NSTextContainer
        // height 를 지정해야 컨텐츠가 보인다.
        textContainer = NSTextContainer(size: CGSize(width: 0, height: CGFloat.greatestFiniteMagnitude))
        textContainer.widthTracksTextView = true  // wrap 하려면 true
        layoutManager.addTextContainer(textContainer)

        // NSTextView 생성 및 설정
        textView = NSTextView(frame: .zero, textContainer: textContainer)
        // max height 를 설정해야 세로스크롤 할 수 있었다.
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)

        textView.isEditable = true
        textView.isVerticallyResizable = true  // 텍스트가 늘어나면 자동으로 길어진다.
        textView.isHorizontallyResizable = false  // wrap 하려면 false
        textView.autoresizingMask = [.width, .height]
//        textView.font = .systemFont(ofSize: 24.0)   // rtf 문서의 폰트를 살리려면 comment out

        scrollView.documentView = textView

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            buttonBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            buttonBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            scrollView.topAnchor.constraint(equalTo: buttonBar.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    @objc func wrapAction(_ sender: NSButton) {
        guard let scrollView = textView.enclosingScrollView else { return }
        if sender.state == .on {
            textContainer.widthTracksTextView = true
            textContainer.size = CGSize(width: 0, height: CGFloat.greatestFiniteMagnitude)
            textView.isHorizontallyResizable = false
            textView.autoresizingMask = [.width, .height]
            textView.frame.size.width = scrollView.contentSize.width
            scrollView.hasHorizontalScroller = false
        } else {
            textContainer.widthTracksTextView = false
            textContainer.size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            textView.isHorizontallyResizable = true
            textView.autoresizingMask = [.height]
            scrollView.hasHorizontalScroller = true
        }
//        print("cc \(textView.frame.size)")
        textView.needsDisplay = true
    }

}
