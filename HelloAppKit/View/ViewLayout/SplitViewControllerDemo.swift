//
//  SplitViewControllerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/23/25.
//

import Cocoa

class SplitViewControllerDemo: NSViewController {

    var window: NSWindow?

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let button1 = NSButton(title: "Open SplitView", target: self, action: #selector(openWindow))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
    }

    @objc func openWindow() {
        if window == nil {
            let window = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )

            window.title = "NSSplitViewController Demo"
            window.isReleasedWhenClosed = false // 윈도우 닫았다가 다시 Open 할 때 크래쉬를 방지.

            window.contentViewController = SplitViewController()

            self.window = window
        }

        window!.center()
        window!.makeKeyAndOrderFront(nil)
    }

    class SplitViewController: NSSplitViewController {

        // NSSplitViewController 는
        // loadView() 를 오버라이드하면 작동을 안 한다.
        // viewDidLoad() 를 쓰기로 한다.

        override func viewDidLoad() {
            super.viewDidLoad()

            let sidebarVC = SidebarViewController()
            let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarVC)
            sidebarItem.canCollapse = true
            sidebarItem.minimumThickness = 150
            sidebarItem.maximumThickness = 250
            addSplitViewItem(sidebarItem)

            let mainVC = MainViewController()
            let mainItem = NSSplitViewItem(viewController: mainVC)
            addSplitViewItem(mainItem)

            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            ])
        }
    }

    class SidebarViewController: NSViewController {
        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.lightGray.cgColor

            let label = NSTextField(labelWithString: "SideBar")
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            ])
        }
    }

    class MainViewController: NSViewController {
        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.white.cgColor

            let label = NSTextField(labelWithString: "Main")
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            ])
        }
    }

}
