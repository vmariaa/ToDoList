//
//  CircleView.swift
//  ToDoList
//
//  Created by Vanda S. on 02/02/2024.
//

import Foundation
import UIKit

class CircleView: UIView {
    override func draw(_ rect: CGRect) {
        // Get the context
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Set the fill color for the circle
        context.setFillColor(UIColor.blue.cgColor)
        
        // Calculate the center and radius of the circle
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let radius = min(centerX, centerY)
        
        // Draw the circle
        context.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        context.fillPath()
    }
}
