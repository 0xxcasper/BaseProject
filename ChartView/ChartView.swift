//
//  ChartView.swift
//  CarBro
//
//  Created by Sang on 11/28/19.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit

struct AppConstant {
    static let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    static let SREEEN_WIDTH = SCREEN_SIZE.width
    static let SCREEN_HEIGHT = SCREEN_SIZE.height
}

class ChartView: BaseView {
    var id: Int = 0
    var _frame = CGRect(x: 0, y: 0, width: 100, height: 100)

    @IBOutlet weak var chartView: BaseViewApp!
    @IBOutlet weak var lblScore: BaseUILabel!
    @IBOutlet weak var lblScoreDetail: BaseUILabel!
    
    @IBOutlet weak var viewCur: UIImageView!
    @IBOutlet weak var viewBase: UIImageView!
    @IBOutlet weak var lblCur: BaseUILabel!
    @IBOutlet weak var lblBase: BaseUILabel!
    
    private var radius:         CGFloat = 0
    private var lineWidth:      Double = 6
    private var maxScore:       Double = 100
    private var curScore:       Double = 20
    private var colors: [UIColor] = []

    override func firstInit() {
        DispatchQueue.main.async {
            self.setupView()
        }
    }
    
    private func setupView() {
        lblScore.setBold(size: .h40)
        lblScoreDetail.text = "Điểm thưởng"
        
        lblCur.setRegular(color: .color_gray_text, size: .h13)
        lblBase.setRegular(color: .color_gray_text, size: .h13)
        viewBase.backgroundColor = .color_chart_background
    }
    
    func setupCircle(curScore: Double, maxScore: Double, colors: [UIColor]) {
        self.curScore = curScore
        self.maxScore = maxScore
        self.colors = colors
        DispatchQueue.main.async {
            self.viewCur.applyGradient(colors: self.colors)
            self.radius = self.chartView.bounds.width / 2 - 12
            self.drawBaseBackground()
            self.drawBaseCircle()
            self.drawScore()
        }
    }
    
    func drawBaseBackground() {
        self.chartView.backgroundColor = .white
        self.chartView.layer.shadowColor = UIColor.gray.cgColor
        self.chartView.layer.shadowOpacity = 0.7
        self.chartView.layer.shadowOffset = CGSize.zero
        self.chartView.layer.cornerRadius = self.chartView.bounds.width / 2
        self.chartView.layer.shadowRadius = 7
    }
    
    private func drawBaseCircle() {
        let layer = CAShapeLayer()
        let path = CGMutablePath()
        let centerPoint = self.chartView.center
        path.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        layer.path = path
        layer.strokeColor = UIColor.color_chart_background.cgColor
        layer.lineWidth = CGFloat(lineWidth)
        layer.fillColor = nil
        self.layer.addSublayer(layer)
    }
    
    private func drawScore() {
        DispatchQueue.main.async {
            let layerScore = CAShapeLayer()
            let path = CGMutablePath()
            let startAngle = CGFloat(3 * Double.pi)/2
            let centerPoint = self.chartView.center
            path.addArc(center: centerPoint, radius: self.radius, startAngle: startAngle, endAngle: startAngle + self.calScore(), clockwise: false)
            layerScore.path = path
            layerScore.strokeColor = UIColor.white.cgColor
            layerScore.lineWidth = CGFloat(self.lineWidth)
            layerScore.fillColor = nil
            
            self.layer.addSublayer(layerScore)
            let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 1.0
            pathAnimation.fromValue = 0.0
            pathAnimation.toValue = 1.0
            pathAnimation.repeatCount = 0
            layerScore.add(pathAnimation, forKey: "strokeEndAnimation")
            
            let gradient = CAGradientLayer()
            gradient.frame = self._frame
            gradient.colors = [self.colors[0].cgColor, self.colors[1].cgColor]
            gradient.startPoint = CGPoint(x : 0.5, y : 0.0)
            gradient.endPoint = CGPoint(x :0.5, y: 1.0)
            gradient.mask = layerScore
            self.layer.addSublayer(gradient)
        }
    }
    
    override func draw(_ rect: CGRect) {
        self._frame = rect
    }
    
    private func calScore() -> CGFloat{
        return CGFloat((curScore * Double.pi * 2) / maxScore)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
