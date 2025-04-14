//
//  Spacer.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/12/25.
//

import Cocoa

class Spacer: NSView {

    init(width: CGFloat, height: CGFloat) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width),
            self.heightAnchor.constraint(equalToConstant: height),
        ])
    }

    convenience init(size: CGFloat) {
        self.init(width: size, height: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
