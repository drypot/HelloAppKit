//
//  EasyStackController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 10/4/24.
//

import AppKit

class EasyStackController: NSViewController {
    
    let padding: CGFloat = 20.0
    let spacing: CGFloat = 8.0
    
    override func loadView() {
        self.view = NSView()
//        view.wantsLayer = true
//        view.layer?.backgroundColor = .white
        
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        addSubviews(to: stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 700),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
    
    func addSubviews(to stackView: NSStackView) {
        fatalError("Implement \(#function)")
    }
    
}
