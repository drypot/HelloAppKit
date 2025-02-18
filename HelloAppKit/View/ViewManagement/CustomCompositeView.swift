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

class CustomCompositeViewDemo: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let childView = CustomCompositeView()
        childView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childView)

        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            childView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            childView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            childView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

}
