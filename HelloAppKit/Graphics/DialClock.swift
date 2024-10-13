//
//  DialClock.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/10/24.
//

import AppKit

// Mastering macOS programming-Packt Publishing (2017), Chapter 10,

class DialClock: NSView {

    var outlineColor: NSColor = .orange
    var innerColor: NSColor = .white
    var lineColor: NSColor = .gray
    
    var timeHours: CGFloat = 8.0
    var timeMinutes: CGFloat = 42.0

    var radius: CGFloat {
        return min(bounds.width, bounds.height) * 0.4
    }
    
    var radiusHours: CGFloat {
        return bounds.width * 0.2
    }
    
    var radiusMinutes: CGFloat {
        return bounds.width * 0.3
    }

    var center: CGPoint {
        return CGPoint(x:bounds.width / 2.0, y: bounds.height / 2.0)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.white.setFill()
        bounds.fill()
        
        // 외곽선 배경
        
        let path = NSBezierPath()
        path.appendArc(
            withCenter: center,
            radius: radius,
            startAngle: 0.0,
            endAngle: 180.0
        )
        path.appendArc(
            withCenter: center,
            radius: radius * 0.25,
            startAngle: 180.0,
            endAngle: 0.0,
            clockwise: true
        )
        path.close()
                
        innerColor.setFill()
        path.fill()
        
        // 분
        
        let pathMinutes = NSBezierPath()
        
        let arcSweepMinutes = CGFloat(timeMinutes) / 60.0 * 180.0
        pathMinutes.appendArc(
            withCenter: center,
            radius: radiusMinutes,
            startAngle: 180.0,
            endAngle: 180.0 - arcSweepMinutes,
            clockwise: true
        )
        
        pathMinutes.lineCapStyle = .round
        let dashes: [CGFloat] = [10, 5]
        pathMinutes.setLineDash(dashes, count: 2, phase: 0)

        lineColor.setStroke()
        pathMinutes.lineWidth = 4
        pathMinutes.stroke()
        
        // 시
        
        let pathHours = NSBezierPath()
        
        let arcSweepHours = CGFloat(timeHours) / 12.0 * 180.0
        pathHours.appendArc(
            withCenter: center,
            radius: radiusHours,
            startAngle: 180.0,
            endAngle: 180.0 - arcSweepHours,
            clockwise: true
        )
        
        lineColor.setStroke()
        pathHours.lineWidth = 5
        pathHours.stroke()
        
        // 외곽선
        
        outlineColor.setStroke()
        path.lineWidth = 4
        path.lineJoinStyle = .round
        path.stroke()        
    }
    
}
