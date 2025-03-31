//
//  TextKit2CommentDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/21/24.
//

import Cocoa

// TextKit
// https://developer.apple.com/documentation/appkit/textkit

// Meet TextKit 2
// https://developer.apple.com/videos/play/wwdc2021/10061/

class TextKit2CommentDemo:
    NSViewController,
    @preconcurrency NSTextContentStorageDelegate,
    @preconcurrency NSTextContentManagerDelegate {

    private var textContentStorage: NSTextContentStorage
    private var textLayoutManager: NSTextLayoutManager

    private var fragmentForCurrentComment: NSTextLayoutFragment?
    private var showComments = true

    //@IBOutlet private weak var textDocumentView: TextDocumentView!

    init() {
        textContentStorage = NSTextContentStorage()

        textLayoutManager = NSTextLayoutManager()
        textLayoutManager.textContainer = NSTextContainer(size: .zero)
        textContentStorage.addTextLayoutManager(textLayoutManager)

        super.init(nibName: nil, bundle: nil)

        textContentStorage.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let buttonBar = NSStackView()
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.orientation = .horizontal
        //        buttonBar.alignment = .leading
        view.addSubview(buttonBar)

        do {
            let button = NSButton(title: "Toggle Comments", target: self, action: #selector(toggleComments))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            button.setButtonType(.pushOnPushOff)
            button.state = .on
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Toggle Frames", target: self, action: #selector(toggleLayerFrames))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            button.setButtonType(.pushOnPushOff)
            button.state = .on
            buttonBar.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Slow Animation", target: self, action: #selector(toggleSlowAnimation))
            button.controlSize = .large
            button.bezelStyle = .toolbar
            button.setButtonType(.pushOnPushOff)
            button.state = .on
            buttonBar.addArrangedSubview(button)
        }

        let content = NSView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.wantsLayer = true
        content.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        view.addSubview(content)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            buttonBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            buttonBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            content.topAnchor.constraint(equalTo: buttonBar.bottomAnchor, constant: 20),
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            content.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if textContentStorage.textStorage!.length == 0 {
            if let docURL = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
                do {
                    try textContentStorage.textStorage?.read(from: docURL, documentAttributes: nil, error: ())
                } catch {
                    // Could not read menu content.
                }
            }
        }
        //        textDocumentView.textContentStorage = textContentStorage
        //        textDocumentView.textLayoutManager = textLayoutManager
        //        textDocumentView.updateContentSizeIfNeeded()
        //        textDocumentView.documentViewController = self
    }

    // Commenting.

    @objc func toggleComments(_ sender: NSButton) {
        showComments = (sender.state == .on)
        //        textDocumentView.layer?.setNeedsLayout()
    }

    func addComment(_ comment: NSAttributedString) {
        //        textDocumentView.addComment(comment, below: fragmentForCurrentComment!)
        fragmentForCurrentComment = nil
    }

    var commentFont: NSFont {
        var commentFont = NSFont.preferredFont(forTextStyle: .title3, options: [:])
        let commentFontDescriptor = commentFont.fontDescriptor.withSymbolicTraits(.italic)
        commentFont = NSFont(descriptor: commentFontDescriptor, size: commentFont.pointSize)!
        return commentFont
    }

    // Debug UI.

    @objc func toggleLayerFrames(_ sender: NSButton) {
        // Turn on/off viewing layer frames.
        //        textDocumentView.showLayerFrames = (sender.state == .on)
        //        textDocumentView.layer?.setNeedsLayout()
    }
    @objc func toggleSlowAnimation(_ sender: NSButton) {
        // Turn on/off slow animation of each layer.
        //        textDocumentView.slowAnimations = (sender.state == .on)
    }

    // Popover management.

    func showCommentPopover(for layoutFragment: NSTextLayoutFragment) {
        fragmentForCurrentComment = layoutFragment
        //        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        //        if let popoverVC = storyboard.instantiateController(withIdentifier: "CommentPopoverViewController") as? CommentPopoverViewController {
        //            popoverVC.documentViewController = self
        //            present(popoverVC, asPopoverRelativeTo: layoutFragment.layoutFragmentFrame,
        //                    of: textDocumentView,
        //                    preferredEdge: .maxY, behavior: .transient)
        //        }
    }

    // MARK: - NSTextContentManagerDelegate

    func textContentManager(
        _ textContentManager: NSTextContentManager,
        shouldEnumerate textElement: NSTextElement,
        options: NSTextContentManager.EnumerationOptions) -> Bool {

            //        if !showComments {
            //            if let paragraph = textElement as? NSTextParagraph {
            //                let commentDepthValue = paragraph.attributedString.attribute(.commentDepth, at: 0, effectiveRange: nil)
            //                if commentDepthValue != nil {
            //                    return false
            //                }
            //            }
            //        }
            return true
        }

    // MARK: - NSTextContentStorageDelegate

    func textContentStorage(
        _ textContentStorage: NSTextContentStorage,
        textParagraphWith range: NSRange) -> NSTextParagraph? {
            //
            //        // In this method, we'll inject some attributes for display, without modifying the text storage directly.
            var paragraphWithDisplayAttributes: NSTextParagraph? = nil
            //
            //        // First, get a copy of the paragraph from the original text storage.
            //        let originalText = textContentStorage.textStorage!.attributedSubstring(from: range)
            //        if originalText.attribute(.commentDepth, at: 0, effectiveRange: nil) != nil {
            //            // Use white colored text to make our comments visible against the bright background.
            //            let displayAttributes: [NSAttributedString.Key: AnyObject] = [.font: commentFont, .foregroundColor: commentColor]
            //            let textWithDisplayAttributes = NSMutableAttributedString(attributedString: originalText)
            //            // Use the display attributes for the text of the comment itself, without the reaction.
            //            // The last character is the newline, second to last is the attachment character for the reaction.
            //            let rangeForDisplayAttributes = NSRange(location: 0, length: textWithDisplayAttributes.length - 2)
            //            textWithDisplayAttributes.addAttributes(displayAttributes, range: rangeForDisplayAttributes)
            //
            //            // Create our new paragraph with our display attributes.
            //            paragraphWithDisplayAttributes = NSTextParagraph(attributedString: textWithDisplayAttributes)
            //        } else {
            //            return nil
            //        }
            //        // If the original paragraph wasn't a comment, this return value will be nil.
            //        // The text content storage will use the original paragraph in this case.
        return paragraphWithDisplayAttributes
    }
    
}
