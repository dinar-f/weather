//
//  CustomTabBar.swift
//  weather
//
//  Created by Dinar on 02.01.2025.
//

import UIKit

final class CustomTabBar: UITabBar {
    
    private var shapeLayer: CALayer? = nil
    private var circleLayer: CALayer? = nil
    
    override func draw(_ rect: CGRect) {
        drawTabBar()
    }
    
    private func drawTabBar() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath()
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineWidth = 2
        
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.layer.insertSublayer(circleLayer, at: 1)
        
        self.shapeLayer = shapeLayer
        self.circleLayer = circleLayer
        
    }
    
    private func shapePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.close()
        return path.cgPath
    }
    
    private func circlePath() -> CGPath {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.width / 2, y: 12),
                    radius: 27,
                    startAngle: 180 * .pi / 180,
                    endAngle: 0 * 180 / .pi,
                    clockwise: true)
        return path.cgPath
    }
}
