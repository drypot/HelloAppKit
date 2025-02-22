//
//  ScrollViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/22/25.
//

import Cocoa

class ScrollViewDemo: NSViewController {

    let scrollView = NSScrollView()
    var constrainsts = [NSLayoutConstraint]()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupScrollView()
        setupContent()

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

    func setupContent() {
        let documentView = NSView()
        documentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = documentView

        var lastItem: NSView?
        for i in 0..<128 {
            let label = NSTextField(labelWithString: "\(i)")
            label.translatesAutoresizingMaskIntoConstraints = false
            documentView.addSubview(label)

            constrainsts.append(contentsOf: [
                label.leadingAnchor.constraint(equalTo: documentView.leadingAnchor, constant: 20)
            ])
            if let lastItem {
                constrainsts.append(
                    label.topAnchor.constraint(equalTo: lastItem.bottomAnchor, constant: 8)
                )
            } else {
                constrainsts.append(
                    label.topAnchor.constraint(equalTo: documentView.topAnchor, constant: 20)
                )
            }

            lastItem = label
        }

        constrainsts.append(contentsOf: [
            documentView.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor),
            documentView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor),
            documentView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor),
            documentView.bottomAnchor.constraint(equalTo: lastItem!.bottomAnchor, constant: 20),
        ])
    }

}
