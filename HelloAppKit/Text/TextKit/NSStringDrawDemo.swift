//
//  NSStringDrawDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/26/25.
//


//
//  TextKitDrawDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/26/25.
//

import AppKit

// Cocoa Text Architecture Guide / Text System Organization
// https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextSystemArchitecture/ArchitectureOverview.html#//apple_ref/doc/uid/TP40009459-CH7-CJBJHGAG

class NSStringDrawDemo: NSViewController {

    private let demoView = DemoView()

    override func loadView() {
        view = NSView()

        demoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(demoView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            demoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            demoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            demoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            demoView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

    class DemoView: NSView {
        override func draw(_ dirtyRect: NSRect) {
            super.draw(dirtyRect)

            let text = "Hello, TextKit" as NSString
            let attributes: [NSAttributedString.Key: Any] = [
                .font: NSFont.preferredFont(forTextStyle: .title3),
                .foregroundColor: NSColor.black
            ]

            let textSize = text.size(withAttributes: attributes)
            let textOrigin = NSPoint(
                x: (bounds.width - textSize.width) / 2,
                y: (bounds.height - textSize.height) / 2
            )

            text.draw(at: textOrigin, withAttributes: attributes)
        }
    }

}
