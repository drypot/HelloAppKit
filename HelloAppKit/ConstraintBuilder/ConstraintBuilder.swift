//
//  ConstraintBuilder.swift
//
//  Created by Kyuhyun Park on 7/11/24.
//

import Cocoa

class ConstraintBuilder {
    
    private var constraints: [NSLayoutConstraint] = []
    
    func activate() {
        NSLayoutConstraint.activate(constraints)
    }

    func append(_ constraint: NSLayoutConstraint) {
        self.constraints.append(constraint)
    }
    
    func append(_ constraints: [NSLayoutConstraint]) {
        self.constraints.append(contentsOf: constraints)
    }
    
    func setSize(of view: NSView, width: CGFloat, height: CGFloat) {
        constraints.append(view.widthAnchor.constraint(equalToConstant: width))
        constraints.append(view.heightAnchor.constraint(equalToConstant: height))
    }
    
    func setWidth(of view: NSView, width: CGFloat) {
        constraints.append(view.widthAnchor.constraint(equalToConstant: width))
    }
    
    func setHeight(of view: NSView, height: CGFloat) {
        constraints.append(view.heightAnchor.constraint(equalToConstant: height))
    }

    func setMinSize(of view: NSView, width: CGFloat, height: CGFloat) {
        constraints.append(view.widthAnchor.constraint(greaterThanOrEqualToConstant: width))
        constraints.append(view.heightAnchor.constraint(greaterThanOrEqualToConstant: height))
    }
    
    func stickEdges(of view: NSView, to parent: NSView, padding: CGFloat = 20) {
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: padding).isActive = true
        view.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -padding).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: padding).isActive = true
        view.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -padding).isActive = true
    }

    /*
    func stickTopTo(_ other: NSView, padding: CGFloat) {
        view.topAnchor.constraint(equalTo: other.topAnchor, constant: padding).isActive = true
    }
    
    func alignXCenterTo(_ other: NSView) {
        view.centerXAnchor.constraint(equalTo: other.centerXAnchor).isActive = true
    }
    
    func alignYCenterTo(_ other: NSView) {
        view.centerYAnchor.constraint(equalTo: other.centerYAnchor).isActive = true
    }
    */
}
