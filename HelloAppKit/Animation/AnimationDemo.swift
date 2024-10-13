//
//  AnimationDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 10/4/24.
//

import AppKit

// Mastering macOS programming-Packt Publishing (2017), Chapter 11,
// 딱히 당장 쓸 일이 없을 것 같아서 챕터 후반은 스킵.

class AnimationDemoRunner: SubRunner {
}

class AnimationDemoController: NSViewController {
    
    var customView: NSView!
    
    var goButton: NSButton!
    
    var cosmicDoor: CALayer!
    var subLayer: CATextLayer!
    var shapeLayer: CAShapeLayer!
    var textLayer: CATextLayer!
    
    var circleLayers: [CALayer] = []
    var squareLayers: [CALayer] = []
    var cubeLayers: [CALayer] = []
    
    var transformLayer: CATransformLayer!
    
    var colors: [CGColor] = [
        .transparentGold,
        .silver,
        .transparentGold,
        .silver,
        .transparentGold
    ]
    
    let easeInOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

    let strings = ["Reading", "Loading", "Ready..."]
    let lockedString = "Locked"
    let unlockedString = "Unlocked"
    
    override func loadView() {
        self.view = NSView()
        view.wantsLayer = true
        customView = view // 책에선 view, customView 별도로 만들었는데, 귀찮으니 일단 하나로 해보자;
        
        setUpButton()
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 700),
            view.heightAnchor.constraint(equalToConstant: 500),

//            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 700),
//            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 500),
            
//            view.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
//            view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
//            view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }

    override func viewDidAppear() {
        customView.layer?.backgroundColor = .black
        buildCosmicDoor()
        buildCircleLayers()
        buildShapeLayer()
        buildTextLayer()
        buildSquareLayers()
    }

    func setUpButton() {
        goButton = NSButton(
            title: "Go",
            target: self,
            action: #selector(buttonClicked)
        )
        goButton.wantsLayer = true
        goButton.frame = NSRect(x: 620, y: 10, width: 60, height: 20)
        goButton.bezelStyle = .recessed
        goButton.layer?.backgroundColor = .gold
        goButton.layer?.cornerRadius = 5.0
        customView.addSubview(goButton)
    }
    
    @objc func buttonClicked() {
        print("Button clicked")
        //moveShapeLayer()
        cosmicDoorExplicitAnimation()
        squareLayersTimingAnimation()
        keyframeShapeAnimation()
        textLayerKeyFrameAnimation()
        //groupAnimation()
        shapeLayerTransaction()
        affineTransformAnimation()
    }
    
    func buildCosmicDoor() {
        cosmicDoor = CALayer()
        cosmicDoor.bounds = CGRect(x: 0, y: 0, width: 200.0, height: customView.bounds.height * 0.8)
        cosmicDoor.position = CGPoint(x: 120.0, y: customView.bounds.height * 0.5)
        cosmicDoor.backgroundColor = .black
        cosmicDoor.borderWidth = 1.0
        cosmicDoor.borderColor = .black
        customView.layer?.addSublayer(cosmicDoor)

        cosmicDoor.shadowColor = .gold
        cosmicDoor.shadowOffset = CGSize(width: 5.0, height: -5.0)
        cosmicDoor.shadowRadius = 15.0
        cosmicDoor.shadowOpacity = 1.0
    }
    
    func buildCircleLayers() {
        let layer = CALayer()
        layer.bounds = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        layer.position = CGPoint(x: 130, y: 40)
        layer.borderWidth = 2.0
        layer.borderColor = .gold
        layer.cornerRadius = layer.bounds.width * 0.5
        
        circleLayers.append(layer)
        cosmicDoor.addSublayer(layer)
    }
    
    func buildShapeLayer() {
        shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
        shapeLayer.position = CGPoint(x: 334.0, y: 45)
        
        shapeLayer.shadowColor = .white
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 15.0
        shapeLayer.shadowOpacity = 1.0
        
        // CAShapeLayer properties
        shapeLayer.fillColor = .transparentGold
        shapeLayer.strokeColor = .niceRed
        shapeLayer.lineWidth = 3.0
        shapeLayer.lineDashPattern = [5.0, 3.0]
        shapeLayer.lineDashPhase = 0.0
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 0.0
        
        let path = CGPath(ellipseIn: shapeLayer.bounds, transform: nil)
        shapeLayer.path = path
        
        var transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        let rotation = Double.pi * 0.55
        transform = CATransform3DRotate(transform, CGFloat(rotation), 1.0, 1.0, 0.0)
        shapeLayer.transform = transform
        
        customView.layer?.addSublayer(shapeLayer)
    }
    
    func shapeLayerTransaction() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(5.0)
        shapeLayer.shadowOffset.height = 5.0
        shapeLayer.shadowOpacity = 1.0
        shapeLayer.lineDashPattern = [10.0, 3.0]
        shapeLayer.lineDashPhase = 90.0
        shapeLayer.strokeEnd = 1.0
        CATransaction.commit()
    }
    
    func buildTextLayer()  {
        textLayer = CATextLayer()
        textLayer.backgroundColor = .gold
        textLayer.opacity = 0.3
        textLayer.shadowColor = .gold
        textLayer.shadowOffset = CGSize(width: 5.0, height: -5.0)
        textLayer.shadowRadius = 15.0
        textLayer.shadowOpacity = 1.0
        textLayer.bounds = CGRect(x: 0, y: 0, width: 200, height: 34.0)
        textLayer.position = CGPoint(x: 394, y: 430)
        
        let fontName = "Luminari" as CFString
        textLayer.font = CTFontCreateWithName(fontName, 0.0, nil)
        textLayer.fontSize = 24.0
        textLayer.string = lockedString
        textLayer.foregroundColor = .black
        textLayer.isWrapped = true
        textLayer.alignmentMode = .center
        textLayer.contentsScale = (NSScreen.main?.backingScaleFactor)!
        
        customView.layer?.addSublayer(textLayer)
    }
    
    func moveShapeLayer() {
        CATransaction.setAnimationDuration(3.0)
        shapeLayer.position = CGPoint(
            x: customView.bounds.width * 0.5,
            y: customView.bounds.height * 0.5
        )
    }
    
//    CABasicAnimation does not affect the model layer values of the view, that is, the view model.
//    As far as the layer is concerned, its height property remained unchanged at all times, even during the animation.
//    CABasicAnimation changes the appearance of the layer, but not its properties.
    
    func cosmicDoorExplicitAnimation() {
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        animation.duration = 3.0
        animation.fromValue = 0.0
        animation.toValue = view.bounds.height * 0.8
        cosmicDoor.add(animation, forKey: nil)
    }
    
    func buildSquareLayers() {
        for i in 0 ..< colors.count {
            let layer = CALayer()
            layer.bounds = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
            layer.position = CGPoint(x: 52 + 34 * i, y: 30)
            layer.borderColor = colors[i]
            layer.borderWidth = 2.0
            squareLayers.append(layer)
            customView.layer?.addSublayer(layer)
        }
    }
    
    func squareLayersTimingAnimation() {
        for i in 0 ..< squareLayers.count {
            let layer = squareLayers[i]
            let newPosition = CGPoint(x: layer.position.x, y: layer.position.y + 50.0)
            let animation = CABasicAnimation(keyPath: "position.y")
            animation.toValue = newPosition.y
            animation.duration = 1.0
            animation.beginTime = CACurrentMediaTime() + Double(i) * 0.2;
            animation.autoreverses = true
            animation.timingFunction = easeInOut
            animation.repeatCount = 3
            layer.add(animation, forKey: nil)
        }
    }
    
    func keyframeShapeAnimation()
    {
        let kfaY = CAKeyframeAnimation(keyPath: "position.y")
        kfaY.values = [
            shapeLayer.position.y,
            80.0, 30.0, 60.0, 30.0, 120.0,
            shapeLayer.position.y
        ]
        kfaY.duration = 10.0
        kfaY.calculationMode = .cubic
        shapeLayer.add(kfaY, forKey: nil)
        
        let kfaX = CAKeyframeAnimation(keyPath: "position.x")
        kfaX.values = [
            shapeLayer.position.x,
            shapeLayer.position.x - 10.0,
            shapeLayer.position.x + 20.0,
            shapeLayer.position.x - 10.0,
            shapeLayer.position.x
        ]
        kfaX.duration = 10.0
        kfaX.calculationMode = .cubic
        shapeLayer.add(kfaX, forKey: nil)
    }
    
    func textLayerKeyFrameAnimation() {
        let kfa = CAKeyframeAnimation(keyPath: "string")
        kfa.values = strings
        kfa.duration = 5.0
        textLayer.add(kfa, forKey: nil)
        textLayer.string = strings.last
    }
    
    func groupAnimation() {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 5.0
        groupAnimation.timingFunction = easeInOut
        
        let kfa1 = CAKeyframeAnimation(keyPath: "opacity")
        kfa1.values = [
            1.0,
            0.2, 1.0, 0.2, 1.0, 0.6,
            1.0
        ]
        kfa1.duration = 2.0
        kfa1.calculationMode = .linear
        
        let kfa2 = CAKeyframeAnimation(keyPath: "position.y")
        kfa2.values = [
            shapeLayer.position.y,
            100.0, 20.0, 100.0,
            200.0
        ]
        kfa2.calculationMode = .cubicPaced
        
        groupAnimation.animations = [kfa1, kfa2]
        shapeLayer.add(groupAnimation, forKey: nil)
    }
    
    func affineTransformAnimation() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(10.0)
        shapeLayer.setAffineTransform(CGAffineTransform(translationX: 0.0, y: 10))
        CATransaction.commit()
    }
    
}
