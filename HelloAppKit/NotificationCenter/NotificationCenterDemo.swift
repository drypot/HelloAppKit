//
//  NotificationCenterDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/17/25.
//

import AppKit

extension Notification.Name {
    static let customNotification = Notification.Name("customNotification")
}

class NotificationCenterDemo: NSViewController {

    deinit {
        removeObserver()
    }

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupNotification()

        let button1 = NSButton(title: "Send Notification", target: self, action: #selector(postNotification))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    private func setupNotification() {
        print("added observer:")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: .customNotification,
            object: nil
        )
    }

    nonisolated private func removeObserver() {
        NotificationCenter.default.removeObserver(self)
        print("removed observer:")
    }

    @objc func postNotification(_ sender: NSButton) {
        print("post notification:")
        NotificationCenter.default.post(
            name: .customNotification,
            object: nil,
            userInfo: ["message": "Hello from NotificationCenter!"]
        )
    }

    @objc func handleNotification(_ notification: Notification) {
        if  let userInfo = notification.userInfo,
            let message = userInfo["message"] as? String {
            print("received notification: \(message)")
        }
    }

}
