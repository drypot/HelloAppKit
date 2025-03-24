//
//  TextKit2Demo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import Cocoa

// TextKit
// https://developer.apple.com/documentation/appkit/textkit

class TextKit2Demo: NSViewController {
    //

    //
    //    override func loadView() {
    //
    //
    //        // Create the core text components
    //
    //        // Connect the components
    //        textContentStorage.addTextLayoutManager(textLayoutManager)
    //        textLayoutManager.textContainer = textContainer
    //
    //        // Create and configure the viewport layout controller
    //        viewportLayoutController = NSTextViewportLayoutController(textLayoutManager: textLayoutManager)
    //        viewportLayoutController.delegate = self
    //
    //        // Create a text view
    //        textView = NSView(frame: view.bounds)
    //        textView.autoresizingMask = [.width, .height]
    //        view.addSubview(textView)
    //
    //        // Set the viewport for the controller
    //        let viewportRect = CGRect(origin: .zero, size: textView.bounds.size)
    //        viewportLayoutController.viewport = viewportRect
    //
    //        // Add some sample text
    //        let attributedString = NSAttributedString(
    //            string: "This is a sample text using NSTextViewportLayoutController for layout management in AppKit.",
    //            attributes: [.font: NSFont.systemFont(ofSize: 16)]
    //        )
    //        textContentStorage.attributedString = attributedString
    //
    //        // Initial layout
    //        updateViewport()
    //    }
    //
    //    private func updateViewport() {
    //        // Update the viewport based on current view bounds
    //        let viewportRect = CGRect(origin: .zero, size: textView.bounds.size)
    //        viewportLayoutController.viewport = viewportRect
    //
    //        // Ensure layout is complete
    //        viewportLayoutController.layoutViewport()
    //    }
    //
    //    override func viewDidLayout() {
    //        super.viewDidLayout()
    //        updateViewport()
    //    }
    //}
    //
    //// MARK: - NSTextViewportLayoutControllerDelegate
    //extension TextKit2Demo: NSTextViewportLayoutControllerDelegate {
    //    func viewportBoundsDidChange(for textViewportLayoutController: NSTextViewportLayoutController) {
    //        // Handle viewport bounds changes
    //        textViewportLayoutController.layoutViewport()
    //
    //        // Request redisplay of text view
    //        textView.needsDisplay = true
    //    }
    //
    //    func textViewportLayoutController(_ textViewportLayoutController: NSTextViewportLayoutController, configureRenderingSurfaceFor textLayoutFragment: NSTextLayoutFragment) {
    //        // Create or reuse a view for the text layout fragment
    //        var fragmentView = textLayoutFragment.renderingSurfaceProvider as? NSTextField
    //
    //        if fragmentView == nil {
    //            fragmentView = NSTextField(frame: textLayoutFragment.layoutFragmentFrame)
    //            fragmentView?.isEditable = false
    //            fragmentView?.isBordered = false
    //            fragmentView?.drawsBackground = false
    //            fragmentView?.attributedStringValue = textLayoutFragment.attributedString!
    //            textView.addSubview(fragmentView!)
    //
    //            // Set the rendering surface provider
    //            textLayoutFragment.renderingSurfaceProvider = fragmentView
    //        } else {
    //            // Update existing view
    //            fragmentView?.frame = textLayoutFragment.layoutFragmentFrame
    //            fragmentView?.attributedStringValue = textLayoutFragment.attributedString!
    //        }
    //    }
    //
    //    func textViewportLayoutController(_ textViewportLayoutController: NSTextViewportLayoutController, removeRenderingSurfaceFor textLayoutFragment: NSTextLayoutFragment) {
    //        // Remove the view associated with this fragment
    //        if let fragmentView = textLayoutFragment.renderingSurfaceProvider as? NSView {
    //            fragmentView.removeFromSuperview()
    //            textLayoutFragment.renderingSurfaceProvider = nil
    //        }
    //    }
    //}
    //
    //// Implementation of a custom NSTextViewportLayoutControllerViewProvider
    //class TextViewportProvider: NSObject, NSTextViewportLayoutControllerViewProvider {
    //    weak var view: NSView?
    //
    //    init(view: NSView) {
    //        self.view = view
    //        super.init()
    //    }
    //
    //    func viewForTextLayoutFragment(_ textLayoutFragment: NSTextLayoutFragment) -> NSView? {
    //        let textView = NSTextField(frame: textLayoutFragment.layoutFragmentFrame)
    //        textView.isEditable = false
    //        textView.isBordered = false
    //        textView.drawsBackground = false
    //        textView.attributedStringValue = textLayoutFragment.attributedString!
    //        return textView
    //    }
    //}

}
