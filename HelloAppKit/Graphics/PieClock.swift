//
//  PieClock.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/10/24.
//

import AppKit

// Mastering macOS programming-Packt Publishing (2017), Chapter 10,

class PieClock: NSView {

    var color1: NSColor = .orange
    var color2: NSColor = .white
    
    var center: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    var timeHours: CGFloat = 11.0
    var timeMinutes: CGFloat = 42.0
    let numberRectSize: CGFloat = 25.0
    
    var context: CGContext {
        return NSGraphicsContext.current!.cgContext
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.white.setFill()
        bounds.fill()
        
        drawFace(clockRect: bounds)
        drawMinutes(minutes: timeMinutes, clockRect: bounds)
        drawHours(context: context, hours: timeHours, clockRect: bounds)
    }
    
    func drawFace(clockRect: CGRect) {
        let circle = NSBezierPath(ovalIn: clockRect)
        
        // Demo AppKit gradient
        
        if let gradient = NSGradient(starting: color1, ending: color2) {
            gradient.draw(in: circle, angle: 90.0)
        }
    }
    
    func drawMinutes(minutes: CGFloat, clockRect: CGRect) {
        let sweep: CGFloat = (60.0 - minutes) / 60.0 * 360
        let radius = min(clockRect.size.width, clockRect.size.height) / 2.0
        
        let path = NSBezierPath()
        path.move(to: center)
        path.appendArc(
            withCenter: center,
                       radius: radius,
                       startAngle: 90.0,
                       endAngle: 90.0 + sweep
        )
        path.close()
        
        // Demo CG gradient
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [
            color1.cgColor,
            color2.cgColor,
            color1.cgColor,
            color2.cgColor,
            color1.cgColor
        ]
        //let colors = [color1.cgColor, color2.cgColor]
        let colorLocations:[CGFloat] = [0.0, 0.3, 0.5, 0.7, 1.0]
        
        let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations
        )!
        let startPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x:bounds.width, y:0.0)
        
        context.saveGState()
        path.addClip()
        context.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: []
        )
        context.restoreGState()
    }
    
    func drawHours(context: CGContext, hours: CGFloat, clockRect: CGRect) {
        let numbersRadius = (min(clockRect.size.width, clockRect.size.height) - numberRectSize) / 2.0
        let numberRect = CGRect(
            x: 0 - numberRectSize * 0.5,
            y: numbersRadius - numberRectSize / 2.0,
            width: numberRectSize,
            height: numberRectSize
        )
//        let path = NSBezierPath(rect: numberRect)
//        NSColor.white.setFill()
        
        context.translateBy(x: bounds.width * 0.5, y: bounds.height * 0.5)
                
        let textAttributes = hourTextAttributes(clockRect: clockRect)
        
        for i in 0..<12 {
            context.saveGState()
            
            context.setShadow(
                offset: CGSize(width: 3.0, height: -5.0),
                blur: 5,
                color: NSColor.gray.cgColor
            )
            
            let rotation = 2.0 * .pi / 12.0 * CGFloat(i)
            context.rotate(by: rotation)
            
//            path.fill()
            
            let numberString = "\(12 - i)"
            numberString.draw(in: numberRect, withAttributes: textAttributes)
            
            context.restoreGState()
        }
    }
    
    func hourTextAttributes(clockRect: CGRect) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let textSize = min(clockRect.size.width, clockRect.size.height) * 0.08
        let textAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: NSFont(name: "Verdana", size: textSize)!
        ]
        return textAttributes
    }
}
