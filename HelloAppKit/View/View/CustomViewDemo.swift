//
//  CustomViewDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class CustomViewDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let customView = CustomView(frame: .zero, color: .green)
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
}

class CustomView: NSView {

    var color: NSColor

    init(frame frameRect: NSRect, color: NSColor) {
        self.color = color
        super.init(frame: frameRect)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // View Clipping Changes in macOS 14 Sonoma
    // https://indiestack.com/2023/06/view-clipping-sonoma/
    //
    // macOS 14 Sonoma 에서 dirtyRect 운영 방법이 바뀌었다고 한다.
    // 이제 dirtyRect.fill() 하면 뷰 밖까지 칠해버린다.
    // 해서 self.bounds.fill() 을 대신 써야 한다.
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        guard let context = NSGraphicsContext.current?.cgContext else { return }

        // color.setFill()
        context.setFillColor(color.cgColor)

        // self.bounds.fill()
        context.fill(bounds)

        print("frame: \(frame)")
        print("bounds: \(bounds)")
        print("")
    }
    
    override func mouseDown(with event: NSEvent) {
        print("CustomView \(color) clicked")
    }
    
}
