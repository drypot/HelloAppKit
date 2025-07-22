//
//  SymbolDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/23/25.
//

import Cocoa

class SymbolDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor

        // Setup StackView

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 50
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])

        let size = 50.0

        do {
            // TintColor
            let config = NSImage.SymbolConfiguration(pointSize: size, weight: .regular)
            let image = NSImage(systemSymbolName: "speaker.wave.2.circle.fill", accessibilityDescription: nil)!
            let imageView = NSImageView(image: image)
            imageView.symbolConfiguration = config
            imageView.contentTintColor = .systemBlue
            stackView.addArrangedSubview(imageView)
        }
        do {
            // hierarchicalColor
            let config = NSImage.SymbolConfiguration(pointSize: size, weight: .regular)
                .applying(.init(hierarchicalColor: .labelColor))
            let image = NSImage(systemSymbolName: "speaker.wave.2.circle.fill", accessibilityDescription: nil)!
            let imageView = NSImageView(image: image)
            imageView.symbolConfiguration = config
            stackView.addArrangedSubview(imageView)
        }
        do {
            // paletteColors
            let config = NSImage.SymbolConfiguration(pointSize: size, weight: .regular)
                .applying(.init(paletteColors: [.white, .controlAccentColor]))
            let image = NSImage(systemSymbolName: "speaker.wave.2.circle.fill", accessibilityDescription: nil)!
            let imageView = NSImageView(image: image)
            imageView.symbolConfiguration = config
            stackView.addArrangedSubview(imageView)
        }
        do {
            // hierarchicalColor
            let config = NSImage.SymbolConfiguration(pointSize: size, weight: .regular)
                .applying(.init(hierarchicalColor: .labelColor))
            let image = NSImage(systemSymbolName: "cloud.sun.rain", accessibilityDescription: nil)!
            let imageView = NSImageView(image: image)
            imageView.symbolConfiguration = config
            stackView.addArrangedSubview(imageView)
        }
        do {
            // multiColor
            let config = NSImage.SymbolConfiguration(pointSize: size, weight: .regular)
                .applying(.preferringMulticolor())
            let image = NSImage(systemSymbolName: "cloud.sun.rain.fill", accessibilityDescription: nil)!
            let imageView = NSImageView(image: image)
            imageView.symbolConfiguration = config
            imageView.wantsLayer = true
            imageView.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
            stackView.addArrangedSubview(imageView)
        }
        do {
            // multiColor
            let config = NSImage.SymbolConfiguration(pointSize: size, weight: .regular)
                .applying(.preferringMulticolor())
            let image = NSImage(systemSymbolName: "folder.badge.plus", accessibilityDescription: nil)!
            let imageView = NSImageView(image: image)
            imageView.symbolConfiguration = config
            stackView.addArrangedSubview(imageView)
        }
    }
}
