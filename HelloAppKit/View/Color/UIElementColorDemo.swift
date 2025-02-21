//
//  UIElementColorDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class UIElementColorDemo: NSViewController {

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
        scrollView.drawsBackground = false;

        view.addSubview(scrollView)

        constrainsts.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        addColorLabel("textColor / textBackgroundColor", .textColor, .textBackgroundColor)
        addColorLabel("selectedTextColor / selectedTextBackgroundColor", .selectedTextColor, .selectedTextBackgroundColor)
        addColorLabel("unemphasizedSelectedTextColor / unemphasizedSelectedTextBackgroundColor", .unemphasizedSelectedTextColor, .unemphasizedSelectedTextBackgroundColor)

        // [accentColor brightnessComponent] < 0.5) ? [NSColor whiteColor] : [NSColor blackColor]

        addSectionLabel("Content Colors")
        addColorLabel("linkColor", .linkColor)
        addColorLabel("separatorColor", .separatorColor)
        addColorLabel("selectedControlTextColor / selectedContentBackgroundColor", .selectedControlTextColor, .selectedContentBackgroundColor)
        addColorLabel("alternateSelectedControlTextColor / selectedContentBackgroundColor", .alternateSelectedControlTextColor, .selectedContentBackgroundColor)
        addColorLabel("secondaryLabelColor / unemphasizedSelectedContentBackgroundColor", .secondaryLabelColor, .unemphasizedSelectedContentBackgroundColor)

        addSectionLabel("Menu Colors")
        addColorLabel("selectedMenuItemTextColor", .selectedMenuItemTextColor)

        addSectionLabel("Table Colors")
        addColorLabel("labelColor / gridColor", .labelColor, .gridColor)
        addColorLabel("headerTextColor", .headerTextColor)
        addColorLabel("labelColor / alternatingContentBackgroundColors[0]", .labelColor, .alternatingContentBackgroundColors[0])
        addColorLabel("labelColor / alternatingContentBackgroundColors[1]", .labelColor, .alternatingContentBackgroundColors[1])

        addSectionLabel("Control Colors")
        addColorLabel("controlTextColor / controlColor", .controlTextColor, .controlColor)
        addColorLabel("disabledControlTextColor / controlColor", .disabledControlTextColor, .controlColor)
        addColorLabel("controlTextColor / controlAccentColor", .controlTextColor, .controlAccentColor)
        addColorLabel("alternateSelectedControlTextColor / controlAccentColor", .alternateSelectedControlTextColor, .controlAccentColor)
        addColorLabel("controlTextColor / controlBackgroundColor", .controlTextColor, .controlBackgroundColor)
        addColorLabel("selectedControlTextColor / selectedControlColor", .selectedControlTextColor, .selectedControlColor)
        addColorLabel("alternateSelectedControlTextColor / selectedControlColor", .alternateSelectedControlTextColor, .selectedControlColor)
        addColorLabel("scrubberTexturedBackground", .controlTextColor, .scrubberTexturedBackground)

        addSectionLabel("Window Colors")
        addColorLabel("windowBackgroundColor", .textColor, .windowBackgroundColor)
        addColorLabel("windowFrameTextColor", .windowFrameTextColor)
        addColorLabel("underPageBackgroundColor", .textColor, .underPageBackgroundColor)

        addSectionLabel("Highlights and Shadows")
        addColorLabel("findHighlightColor", .findHighlightColor)
        addColorLabel("highlightColor", .highlightColor)
        addColorLabel("shadowColor", .shadowColor)

        constrainsts.append(contentsOf: [
            list.bottomAnchor.constraint(equalTo: lastItem!.bottomAnchor, constant: 20),
        ])
    }

    func addSectionLabel(_ title: String) {
        let text = NSTextField(labelWithString: title)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = NSFont.systemFont(ofSize: 18, weight: .medium)
        text.textColor = NSColor.labelColor
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
