//
//  GraphicsDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

class GraphicsDemoRunner: SubRunner {
}

class GraphicsDemoController: EasyStackController {
        
    override func addSubviews(to stackView: NSStackView) {
        stackView.orientation = .horizontal
        do {
            let button = GraphicButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 200),
            ])
        }

        do {
            let button = GraphicButton()
            button.roundIcon = false
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 200),
            ])
        }

        do {
            let clock = DialClock()
            clock.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(clock)
            
            NSLayoutConstraint.activate([
                clock.widthAnchor.constraint(equalToConstant: 200),
                clock.heightAnchor.constraint(equalToConstant: 200),
            ])
        }
        
        do {
            let clock = PieClock()
            clock.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(clock)
            
            NSLayoutConstraint.activate([
                clock.widthAnchor.constraint(equalToConstant: 200),
                clock.heightAnchor.constraint(equalToConstant: 200),
            ])
        }
        
    }
    
}
