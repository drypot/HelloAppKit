//
//  SplitViewSimpleDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class SplitViewSimpleDemo: NSViewController, NSSplitViewDelegate {

    let splitView = NSSplitView()

    override func loadView() {
        let view = NSView()
        self.view = view

        setupSplitView()

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupSplitView() {
        splitView.translatesAutoresizingMaskIntoConstraints = false
        splitView.isVertical = true  // Split vertically
        splitView.dividerStyle = .thin
        splitView.delegate = self
        view.addSubview(splitView)

        let leftPane = NSView()
        leftPane.wantsLayer = true
        leftPane.layer?.backgroundColor = NSColor.gray.cgColor
        splitView.addArrangedSubview(leftPane)

        let rightPane = NSView()
        rightPane.wantsLayer = true
        rightPane.layer?.backgroundColor = NSColor.lightGray.cgColor
        splitView.addArrangedSubview(rightPane)

        NSLayoutConstraint.activate([
            splitView.topAnchor.constraint(equalTo: view.topAnchor),
            splitView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splitView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splitView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // Optional: Prevent left pane from collapsing completely
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        return false
    }

    // Optional: Set minimum widths
    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return 200
    }
}

