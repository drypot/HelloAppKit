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

    let stackView = NSStackView()

    deinit {
        removeObserver()
    }

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupNotification()

        setupStackView()
        setupStackItems()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        let button1 = NSButton(
            title: "Send Notification",
            target: self,
            action: #selector(postNotification)
        )
        stackView.addArrangedSubview(button1)
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
