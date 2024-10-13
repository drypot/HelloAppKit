//
//  CustomView.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/30/24.
//

import AppKit

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
        
        color.setFill()
        self.bounds.fill()
    }
    
    override func mouseDown(with event: NSEvent) {
        print("CustomView \(color) clicked")
    }
    
}
