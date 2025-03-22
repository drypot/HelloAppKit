//
//  ScrollViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/22/25.
//

import Cocoa

// NSScrollView
// https://developer.apple.com/documentation/appkit/nsscrollview

// Working with Scroll Views
// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html#//apple_ref/doc/uid/TP40010853-CH24-SW1

class ScrollViewDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        // setup ScrollView

        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false;

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        // setup documentView

        let documentView = NSView()
        documentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.documentView = documentView

        var constrainsts = [NSLayoutConstraint]()

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

            // documentView.bottomAnchor 를 scrollView 에 걸지 말고
            // documentView 의 크기를 확정할 수 있는 constraint 들을 추가한다.

            documentView.bottomAnchor.constraint(equalTo: lastItem!.bottomAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate(constrainsts)
    }

}
