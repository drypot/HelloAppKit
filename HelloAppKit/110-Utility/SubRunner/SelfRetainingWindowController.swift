//
//  SelfRetainingWindowController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 10/4/24.
//

import AppKit

class SelfRetainingWindowController: NSWindowController, NSWindowDelegate {
    
    private var selfRetainer: SelfRetainingWindowController?
    
    override init(window: NSWindow?) {
        super.init(window: window)
        self.selfRetainer = self
        self.window?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func windowWillClose(_ notification: Notification) {
        //print("SelfRetainingWindowController windowWillClose")
        selfRetainer = nil
    }

}
