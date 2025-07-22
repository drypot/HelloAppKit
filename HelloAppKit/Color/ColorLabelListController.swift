//
//  ColorLabelListController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class ColorLabelListController: NSViewController {

    let scrollView = NSScrollView()
    let list = NSView()
    var lastItem: NSView?
    var constrainsts = [NSLayoutConstraint]()

    override func loadView() {
        view = NSView()

        setupScrollView()
        setupScrollContent()

        NSLayoutConstraint.activate(constrainsts)
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false;

        view.addSubview(scrollView)

        constrainsts.append(contentsOf: [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func setupScrollContent() {
        let documentView = NSView()
        documentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = documentView

        list.translatesAutoresizingMaskIntoConstraints = false
        documentView.addSubview(list)

        setupLabels()

        constrainsts.append(contentsOf: [
            documentView.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor),
            documentView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor),
            documentView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor),
            documentView.bottomAnchor.constraint(equalTo: list.bottomAnchor, constant: 20),

            list.topAnchor.constraint(equalTo: documentView.topAnchor, constant: 20),
            list.leadingAnchor.constraint(equalTo: documentView.leadingAnchor, constant: 20),
            list.trailingAnchor.constraint(equalTo: documentView.trailingAnchor, constant: -20),
            list.bottomAnchor.constraint(equalTo: lastItem!.bottomAnchor),
        ])
    }

    func setupLabels() {
//        addSectionLabel("Label Colors")
//        addColorLabel("labelColor", .labelColor)
//        addColorLabel("secondaryLabelColor", .secondaryLabelColor)
//        addColorLabel("tertiaryLabelColor", .tertiaryLabelColor)
//        addColorLabel("quaternaryLabelColor", .quaternaryLabelColor)
    }

    func addSectionLabel(_ title: String) {
        let text = NSTextField(labelWithString: title)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = NSFont.systemFont(ofSize: 18, weight: .medium)
        text.textColor = NSColor.labelColor
        list.addSubview(text)

        constrainsts.append(contentsOf: [
            text.leadingAnchor.constraint(equalTo: list.leadingAnchor),
        ])

        if let lastItem {
            constrainsts.append(
                text.topAnchor.constraint(equalTo: lastItem.bottomAnchor, constant: 20)
            )
        } else {
            constrainsts.append(
                text.topAnchor.constraint(equalTo: list.topAnchor)
            )
        }
        lastItem = text
    }

    func addColorLabel(_ title: String, _ foregroundColor: NSColor? = nil, _ backgroundColor: NSColor? = nil) {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsLayer = true
        view.layer?.cornerRadius = 5
        view.layer?.backgroundColor = backgroundColor?.cgColor ?? .clear
        list.addSubview(view)

        let text = NSTextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.stringValue = title
        text.textColor = foregroundColor ?? .labelColor
        text.isBordered = false
        text.isEditable = false
        text.isSelectable = true
        text.drawsBackground = false
        text.font = NSFont.systemFont(ofSize: 14)
        text.alignment = .left
        view.addSubview(text)

        constrainsts.append(contentsOf: [
            view.topAnchor.constraint(equalTo: lastItem!.bottomAnchor, constant: 8),
            view.leadingAnchor.constraint(equalTo: list.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: list.trailingAnchor),

            text.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
        ])
        lastItem = view
    }

}
