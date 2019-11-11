//
//  ViewController.swift
//  testDraw
//
//  Created by Sang on 11/8/19.
//  Copyright © 2019 Carbro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var basePoints: [BasePoint] = []
    var listColor: [UIColor] = []
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let radius: CGFloat = 150
    let lineWidth: CGFloat = 20
    let numberLine: Int = 10
    let maxScore = 1000
    let currentScore = 200
    
    var staticStartAngle: CGFloat = CGFloat((3 * Double.pi)/4)
    let staticEndAngle: CGFloat = CGFloat((9 * Double.pi)/4)
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupView()
        drawBaseCircle()
        drawScore()
        
    }
    
    func setupView() {
        listColor = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray, UIColor.orange,UIColor.red, UIColor.green, UIColor.blue, UIColor.gray, UIColor.orange,UIColor.red, UIColor.green, UIColor.blue, UIColor.gray, UIColor.orange]
        addPoints()
        drawBackGround()
        setup()
    }
    
    
    func animateCAShapeLayerDrawing(){
         let layer = CAShapeLayer()
         let path = CGMutablePath()
         let centerPoint = CGPoint(x: 200, y: 200)
         path.addArc(center: centerPoint, radius: 100, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi) * 2, clockwise: true)
         layer.path = path
         layer.strokeColor = UIColor.black.cgColor
         layer.lineWidth = 5.0
         layer.fillColor = nil
         self.view.layer.addSublayer(layer)
     }
    
    
    func drawBaseCircle() {
        let layer = CAShapeLayer()
        let path = CGMutablePath()
        let centerPoint = CGPoint(x: 200, y: 200)
        path.addArc(center: centerPoint, radius: 100, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        layer.path = path
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 1
        layer.backgroundColor = UIColor.white.cgColor
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 30.0
        layer.fillColor = nil
        self.view.layer.addSublayer(layer)
    }
    
    func calCulatorAngle(maxScore: Double, currentScore: Double) -> CGFloat {
        return (maxScore > currentScore) ? CGFloat((currentScore * Double.pi * 2) / maxScore) : CGFloat(Double.pi * 2)
    }
    
    func drawScore() {
        let layer = CAShapeLayer()
        let path = CGMutablePath()
        let centerPoint = CGPoint(x: 200, y: 200)
        path.addArc(center: centerPoint, radius: 100, startAngle: CGFloat(3 * Double.pi)/2, endAngle: CGFloat(3 * Double.pi)/2 + calCulatorAngle(maxScore: 200, currentScore: 150), clockwise: false)

        layer.path = path
        layer.lineCap = .round
        layer.strokeColor = UIColor.blue.cgColor
        layer.lineWidth = 15.0
        layer.fillColor = nil
        self.view.layer.addSublayer(layer)
    }
    
    func addPoints() {
        let numStep = CGFloat((3 * Double.pi / 2) / Double(numberLine))
        for num in 0...(numberLine - 1) {
            let line = BasePoint(startAngle: staticStartAngle, endAngle: staticStartAngle + numStep, strokeColor: listColor[num])
            staticStartAngle += numStep
            basePoints.append(line)
        }

    }

    func drawBackGround() {
        for point in basePoints {
            CAShapeLayerDrawing(point: point)
        }
    }
    
    func CAShapeLayerDrawing(point: BasePoint){
        let layer = CAShapeLayer()
        let path = CGMutablePath()
        let centerPoint = self.view.center
        path.addArc(center: centerPoint, radius: radius, startAngle: point.getStartAngle(), endAngle: point.getEndAngle(), clockwise: false)
        layer.path = path
        layer.strokeColor = point.getColor()
        layer.lineWidth = lineWidth
        layer.fillColor = nil
        view.layer.addSublayer(layer)
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * Double.pi / 180
    }
    
    func setup() {
        let redLayer = CALayer()
        let radian = deg2rad(135)
        let x = Double(screenWidth/2) + Double(Double(radius + lineWidth / 2) * cos(radian))
        let y = Double(screenHeight/2) + Double(Double(radius + lineWidth / 2) * sin(radian))

        let a = CGPoint(x: x, y: y)
        let b = CGSize(width: lineWidth, height: lineWidth)
        redLayer.frame = CGRect(origin: a, size: b)
        redLayer.backgroundColor = UIColor.blue.cgColor
        self.view.layer.addSublayer(redLayer)
    }
}

class BasePoint {
    
    private var startAngle: CGFloat
    private var endAngle: CGFloat
    private var strokeColor: CGColor
    
    init(startAngle: CGFloat, endAngle: CGFloat, strokeColor: UIColor) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.strokeColor = strokeColor.cgColor
    }
    
    func getStartAngle() -> CGFloat {
        return self.startAngle
    }
    
    func getEndAngle() -> CGFloat {
        return self.endAngle
    }
    
    func getColor() -> CGColor {
        return strokeColor
    }
}

