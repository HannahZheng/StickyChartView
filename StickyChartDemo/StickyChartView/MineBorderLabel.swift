//
//  MineBorderLabel.swift
//  BeiBei
//
//  Created by Han on 2023/7/28.
//

import UIKit

final class BorderLabel: UILabel {
    enum BorderStyle: Int, CaseIterable {
        /// 单线条 左侧
        case left
        /// 单线条 底部
        case bottom
        /// 单线条 右侧
        case right
        /// 单线条 上册
        case top
        /// 左上线条 有圆角
        case left_top
        /// 左下线条 有圆角
        case left_bottom
        /// 右上线条 有圆角
        case right_top
        /// 右下线条 有圆角
        case right_bottom
        /// 左上右线条，且2个角有圆角
        case left_top_right
        /// 左下右线条，且2个角有圆角
        case left_bottom_right
        /// 上左下线条，且2个角有圆角
        case top_left_bottom
        /// 上右下线条，且2个角有圆角
        case top_right_bottom
    }
    
    var borderRadius: CGFloat = 12.0
    var borderWidth: CGFloat = 1.0
    var borderColor: UIColor? = .rgba(151, 151, 151, 0.1)
    var borderStyles: [BorderStyle] = []
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = .round
        layer.lineWidth = borderWidth
        
        layer.fillColor = backgroundColor?.cgColor
        layer.strokeColor = borderColor?.cgColor
        
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        
        layer.insertSublayer(borderLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension BorderLabel {
    
    func drawPath() -> CGPath? {
        guard borderStyles.count > 0 else {
            return nil
        }
        
        let path = CGMutablePath()
        /// 左上角
        let left_top = CGPoint(x: bounds.minX, y: bounds.minY)
        /// 右上角
        let right_top = CGPoint(x: bounds.maxX, y: bounds.minY)
        /// 右下角
        let right_bottom = CGPoint(x: bounds.maxX, y: bounds.maxY)
        /// 左下角
        let left_bottom = CGPoint(x: bounds.minX, y: bounds.maxY)
        
        for style in borderStyles {
            switch style {
            case .left:
                path.move(to: left_top)
                path.addLine(to: left_bottom)
            case .bottom:
                path.move(to: left_bottom)
                path.addLine(to: right_bottom)
            case .right:
                path.move(to: right_bottom)
                path.addLine(to: right_top)
            case .top:
                path.move(to: right_top)
                path.addLine(to: left_top)
                
            case .left_top:
                let point = CGPoint(x: left_top.x + borderRadius, y: left_top.y)
                
                path.move(to: left_bottom)
                path.addArc(tangent1End: left_top, tangent2End: point, radius: borderRadius)
                path.addLine(to: right_top)
                
            case .left_bottom:
                let point = CGPoint(x: left_bottom.x + borderRadius, y: left_bottom.y)
                
                path.move(to: left_top)
                path.addArc(tangent1End: left_bottom, tangent2End: point, radius: borderRadius)
                path.addLine(to: right_bottom)
                
            case .right_top:
                let point = CGPoint(x: right_top.x - borderRadius, y: right_top.y)
                
                path.move(to: right_bottom)
                path.addArc(tangent1End: right_top, tangent2End: point, radius: borderRadius)
                path.addLine(to: left_top)
                
            case .right_bottom:
                let point = CGPoint(x: right_bottom.x - borderRadius, y: right_bottom.y)
                
                path.move(to: right_top)
                path.addArc(tangent1End: right_bottom, tangent2End: point, radius: borderRadius)
                path.addLine(to: left_bottom)
                
            case .left_top_right:
                let point1 = CGPoint(x: left_top.x + borderRadius, y: left_top.y)
                let point2 = CGPoint(x: right_top.x, y: right_top.y + borderRadius)
                
                path.move(to: left_bottom)
                path.addArc(tangent1End: left_top, tangent2End: point1, radius: borderRadius)
                path.addArc(tangent1End: right_top, tangent2End: point2, radius: borderRadius)
                path.addLine(to: right_bottom)
                
            case .left_bottom_right:
                let point1 = CGPoint(x: left_bottom.x + borderRadius, y: left_bottom.y)
                let point2 = CGPoint(x: right_bottom.x, y: right_bottom.y - borderRadius)
                
                path.move(to: left_top)
                path.addArc(tangent1End: left_bottom, tangent2End: point1, radius: borderRadius)
                path.addArc(tangent1End: right_bottom, tangent2End: point2, radius: borderRadius)
                path.addLine(to: right_top)
                
            case .top_left_bottom:
                let point1 = CGPoint(x: left_top.x, y: left_top.y + borderRadius)
                let point2 = CGPoint(x: left_bottom.x + borderRadius, y: left_bottom.y)
                
                path.move(to: right_top)
                path.addArc(tangent1End: left_top, tangent2End: point1, radius: borderRadius)
                path.addArc(tangent1End: left_bottom, tangent2End: point2, radius: borderRadius)
                path.addLine(to: right_bottom)
                
            case .top_right_bottom:
                let point1 = CGPoint(x: right_top.x, y: right_top.y + borderRadius)
                let point2 = CGPoint(x: right_bottom.x - borderRadius, y: right_bottom.y)
                
                path.move(to: left_top)
                path.addArc(tangent1End: right_top, tangent2End: point1, radius: borderRadius)
                path.addArc(tangent1End: right_bottom, tangent2End: point2, radius: borderRadius)
                path.addLine(to: left_bottom)
            }
        }
        
        return path
    }
}

extension BorderLabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        borderLayer.frame = bounds
        borderLayer.path = drawPath()
        
    }
}
