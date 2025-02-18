//
//  SheetWindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class SheetWindowDemo: NSViewController {

    let padding = 20.0
    let stackView = NSStackView()

    var sheetWindowController: SheetWindowController? = nil

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupStackView()
        setupStackItems()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        do {
            let button = NSButton(title: "Open sheet", target: self, action: #selector(openSheet))
            stackView.addArrangedSubview(button)
        }
    }

    @objc func openSheet() {
        if sheetWindowController == nil {
            sheetWindowController = SheetWindowController()
        }
        guard let window = self.view.window else {
            fatalError()
        }
        guard let sheetWindow = sheetWindowController?.window else {
            fatalError()
        }
        window.beginSheet(sheetWindow) { response in
            switch response {
            case .OK:
                print("OK")
            case .cancel:
                print("Cancel")
            default:
                fatalError()
            }
            print("sheet response: \(response)")
        }
    }

    class SheetWindowController: NSWindowController {

        init() {
            // window 는 windowController 가 retain 하므로 따로 retain 하지 않아도 된다.
            let sheetWindow = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable /*, .resizable, .miniaturizable*/],
                backing: .buffered,
                defer: false
            )

            // 쉬트 닫았다가 다시 열 때 터지지 않게 하려면,
            sheetWindow.isReleasedWhenClosed = false

            super.init(window: sheetWindow)

            sheetWindow.title = "Sheet Window"
            sheetWindow.contentViewController = SheetViewController()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    class SheetViewController: NSViewController {

        let padding = 20.0
        let stackView = NSStackView()

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false

            setupStackView()
            setupStackItems()
        }

        private func setupStackView() {
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.orientation = .vertical
            stackView.alignment = .leading
            view.addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
                stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
                stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
                stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            ])
        }

        func setupStackItems() {
            do {
                let button1 = NSButton(title: "Close", target: self, action: #selector(closeSheet))
                stackView.addArrangedSubview(button1)
            }
        }

        @objc private func closeSheet(_ sender: NSButton) {
            guard let window = self.view.window else {
                fatalError()
            }
            window.sheetParent?.endSheet(window)
        }
    }

}
