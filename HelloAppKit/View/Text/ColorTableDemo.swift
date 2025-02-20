//
//  ColorTableDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class ColorTableDemo: NSViewController {

    let scrollView = NSScrollView()
    let list = NSView()
    var lastItem: NSView?
    var constrainsts = [NSLayoutConstraint]()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupScrollView()
        setupList()

        NSLayoutConstraint.activate(constrainsts)
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = list
        scrollView.hasVerticalScroller = true
//        scrollView.borderType = .noBorder

        view.addSubview(scrollView)

        constrainsts.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

//            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
//            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    private func setupList() {
        list.translatesAutoresizingMaskIntoConstraints = false

        addSectionLabel("Label Colors")
        addColorLabel("labelColor", .labelColor)
        addColorLabel("secondaryLabelColor", .secondaryLabelColor)
        addColorLabel("tertiaryLabelColor", .tertiaryLabelColor)
        addColorLabel("quaternaryLabelColor", .quaternaryLabelColor)

        addSectionLabel("Text Colors")
        addColorLabel("textColor", .textColor)
        addColorLabel("placeholderTextColor", .placeholderTextColor)
        addColorLabel("selectedTextColor", .selectedTextColor)
        addColorLabel("keyboardFocusIndicatorColor", .keyboardFocusIndicatorColor)

        addSectionLabel("Text Background Colors")
        addColorLabel("textBackgroundColor", .textColor, .textBackgroundColor)
        addColorLabel("selectedTextBackgroundColor", .selectedTextColor, .selectedTextBackgroundColor)
        addColorLabel("unemphasizedSelectedTextBackgroundColor", .unemphasizedSelectedTextColor, .unemphasizedSelectedTextBackgroundColor)

        addSectionLabel("Content Colors")
        addColorLabel("linkColor", .linkColor)
        addColorLabel("separatorColor", .separatorColor)
        addColorLabel("selectedContentBackgroundColor", .labelColor, .selectedContentBackgroundColor)
        addColorLabel("unemphasizedSelectedTextBackgroundColor", .labelColor, .unemphasizedSelectedTextBackgroundColor)

        addSectionLabel("Table Colors")
        addColorLabel("selectedControlColor", .selectedControlColor)
        addColorLabel("selectedControlTextColor", .selectedControlTextColor)
        addColorLabel("", .quaternaryLabelColor)

        constrainsts.append(contentsOf: [
            //            list.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            //            list.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
//            list.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            list.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            list.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            list.bottomAnchor.constraint(equalTo: lastItem!.bottomAnchor, constant: -20),
        ])
    }

    func addSectionLabel(_ title: String) {
        let text = NSTextField(labelWithString: title)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = NSFont.systemFont(ofSize: 18, weight: .medium)
        text.textColor = NSColor.tertiaryLabelColor
        list.addSubview(text)

        constrainsts.append(contentsOf: [
            text.leadingAnchor.constraint(equalTo: list.leadingAnchor, constant: 20),
            //            text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            //            text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])

        if let lastItem {
            constrainsts.append(contentsOf: [
                text.topAnchor.constraint(equalTo: lastItem.bottomAnchor, constant: 20),
            ])
        } else {
            constrainsts.append(contentsOf: [
                text.topAnchor.constraint(equalTo: list.topAnchor, constant: 20),
            ])
        }
        lastItem = text
    }

    func addColorLabel(_ title: String, _ foregroundColor: NSColor? = nil, _ backgroundColor: NSColor? = nil) {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsLayer = true
        view.layer?.cornerRadius = 5  // Rounded corners
        if let backgroundColor {
            view.layer?.backgroundColor = backgroundColor.cgColor
        }
        list.addSubview(view)

        let text = NSTextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.stringValue = title
        if let foregroundColor {
            text.textColor = foregroundColor
        }
        text.isBordered = false
        text.isEditable = false
        text.isSelectable = true
        text.drawsBackground = false
        text.font = NSFont.systemFont(ofSize: 14)
        text.backgroundColor = .clear  // Make sure it blends with the background
        text.alignment = .left
        text.sizeToFit()
        view.addSubview(text)

        constrainsts.append(contentsOf: [
            view.leadingAnchor.constraint(equalTo: list.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: list.trailingAnchor, constant: -20),
            view.topAnchor.constraint(equalTo: lastItem!.bottomAnchor, constant: 8),

            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            text.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
        ])
        lastItem = view
    }

}
