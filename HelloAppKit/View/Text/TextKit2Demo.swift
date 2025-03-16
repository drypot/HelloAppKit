//
//  TextKit2Demo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import Cocoa

class TextKit2Demo: NSViewController {

//    private let textContentManager = NSTextContentStorage()
//    private let textLayoutManager = NSTextLayoutManager()
//    private let viewportLayoutManager = NSTextViewportLayoutController()
//
//    override func loadView() {
//        view = NSView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        // Configure the text system
//        textContentManager.addTextLayoutManager(textLayoutManager)
//        textLayoutManager.textViewportLayoutController?.layoutViewportManager = viewportLayoutManager
//
//        // Sample text content
//        let textStorage = NSTextStorage(string: "Hello, NSTextContentManager!\nThis is a modern text system example.")
//        textContentManager.textStorage = textStorage
//    }
//
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//        NSColor.white.setFill()
//        dirtyRect.fill()
//
//        guard let context = NSGraphicsContext.current?.cgContext else { return }
//
//        let visibleRect = self.bounds
//        viewportLayoutManager.layoutViewport(with: visibleRect)
//
//        for layoutFragment in viewportLayoutManager.layoutFragments(in: visibleRect) {
//            layoutFragment.draw(at: layoutFragment.layoutFragmentFrame.origin, in: context)
//        }
//    }

}
