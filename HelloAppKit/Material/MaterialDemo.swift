//
//  MaterialDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/15/25.
//

import Cocoa

class MaterialDemo: NSViewController {

    var window: NSWindow?

    override func loadView() {
        view = NSView()

        let button1 = NSButton(title: "Open translucent window", target: self, action: #selector(openWindow))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

//        let button2 = NSButton(title: "Open window 2", target: self, action: #selector(openWindow))
//        button2.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button2)
//
//        let button3 = NSButton(title: "Open window 3", target: self, action: #selector(openWindow))
//        button3.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button3)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

//            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 8),
//            button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//
//            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 8),
//            button3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    @objc func openWindow() {
        if window == nil {
            window = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }

        guard let window else { fatalError() }

        window.title = "Demo"
        window.isReleasedWhenClosed = false // 윈도우 닫았다가 다시 Open 할 때 크래쉬를 방지.
//        window.isOpaque = false
//        window.backgroundColor = .clear

        window.contentViewController = ViewController()
        window.center()
        window.makeKeyAndOrderFront(nil)
    }

    class ViewController: NSViewController {
        override func loadView() {
            view = NSView()
            view.wantsLayer = true

            let effectView = NSVisualEffectView()
            effectView.translatesAutoresizingMaskIntoConstraints = false
            effectView.material = .hudWindow
            effectView.blendingMode = .behindWindow // default
            effectView.state = .active

            view.addSubview(effectView)

            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

                effectView.topAnchor.constraint(equalTo: view.topAnchor),
                effectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                effectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                effectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }

}
