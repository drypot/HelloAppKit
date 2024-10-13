//
//  CustomCompositeView.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import Cocoa

class CustomCompositeView: NSView {
    
    private let childView1 = NSView()
    private let childView2 = NSView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        childView1.wantsLayer = true
        childView1.layer?.backgroundColor = NSColor.red.cgColor
        childView1.translatesAutoresizingMaskIntoConstraints = false
        addSubview(childView1)

        childView2.wantsLayer = true
        childView2.layer?.backgroundColor = NSColor.blue.cgColor
        childView2.translatesAutoresizingMaskIntoConstraints = false
        addSubview(childView2)
        
        NSLayoutConstraint.activate([
            childView1.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            childView1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            childView1.topAnchor.constraint(equalTo: self.topAnchor),
            childView1.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            childView1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            childView2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            childView2.topAnchor.constraint(equalTo: self.topAnchor),
            childView2.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            childView2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
        
        let clickGestureRecognizer = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        self.addGestureRecognizer(clickGestureRecognizer)
    }
        
    @objc func handleClick(_ sender: NSClickGestureRecognizer) {
        let locationInView = sender.location(in: self)
        print("Mouse clicked at: \(locationInView)")
    }
}
