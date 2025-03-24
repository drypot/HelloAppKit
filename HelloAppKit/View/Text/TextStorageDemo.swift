//
//  TextStorageDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/21/25.
//

import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

// Putting an NSTextView Object in an NSScrollView
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextUILayer/Tasks/TextInScrollView.html#//apple_ref/doc/uid/20000938

class TextStorageDemo: NSViewController {

    // textStorage 외에는 로컬 변수에 잠시 담아 써도 되는데
    // 이런 저런 메서드에서 사용할 상황을 대비해 인스턴스 변수로 뽑아놨다.

    private var textStorage: NSTextStorage!
    private var layoutManager: NSLayoutManager!
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

        // NSTextStorage
        textStorage = NSTextStorage(string: "NSTextView with NSTextStorage Demo")

        // NSLayoutManager
        layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        // NSTextContainer
        textContainer = NSTextContainer(size: .zero)
        // size 를 지정해야 컨텐츠가 보인다.
        textContainer.size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        // line wrapping 기능을 끄려면 false, 켜려면 true
        textContainer.widthTracksTextView = true
        layoutManager.addTextContainer(textContainer)

        // NSTextView 생성 및 설정
        textView = NSTextView(frame: .zero, textContainer: textContainer)
        // maxSize 설정을 해야 세로스크롤 할 수 있었다.
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)

        textView.isEditable = true
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        textView.autoresizingMask = [.width, .height]
        textView.font = .systemFont(ofSize: 24.0)

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

}
