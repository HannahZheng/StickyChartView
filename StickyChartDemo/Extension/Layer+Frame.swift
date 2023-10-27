//
//  Layer+Frame.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/17.
//

import UIKit

extension CALayer {
    @discardableResult
    static func + (lhs: CALayer, rhs: CALayer) -> CALayer {
        lhs.addSublayer(rhs)
        return lhs
    }
}

extension CALayer: DuoboCompatible {}

extension Duobo where Object: CALayer {
    var top: CGFloat {
        get { return object.frame.minY }
        set {
            var newFrame = object.frame
            newFrame.origin.y = newValue
            object.frame = newFrame
        }
    }
    
    var bottom: CGFloat {
        get { return object.frame.maxY }
        set {
            var newFrame = object.frame
            newFrame.origin.y = newValue - object.frame.height
            object.frame = newFrame
        }
    }
    
    var left: CGFloat {
        get { return object.frame.minX }
        set {
            var newFrame = object.frame
            newFrame.origin.x = newValue
            object.frame = newFrame
        }
    }
    
    var right: CGFloat {
        get { return object.frame.maxX }
        set {
            var newFrame = object.frame
            newFrame.origin.x = newValue - object.frame.width
            object.frame = newFrame
        }
    }
    
    var centerX: CGFloat {
        get { return object.frame.midX }
        set {
            var newFrame = object.frame
            newFrame.origin.x = newValue - newFrame.size.width * 0.5
            object.frame = newFrame
        }
    }
    
    var centerY: CGFloat {
        get { return object.frame.midY }
        set {
            var newFrame = object.frame
            newFrame.origin.y = newValue - newFrame.size.height * 0.5
            object.frame = newFrame
        }
    }
    
    var width: CGFloat {
        get { return object.frame.width }
        set {
            var newFrame = object.frame
            newFrame.size.width = newValue
            object.frame = newFrame
        }
    }
    
    var height: CGFloat {
        get { return object.frame.height }
        set {
            var newFrame = object.frame
            newFrame.size.height = newValue
            object.frame = newFrame
        }
    }
    
    var origin: CGPoint {
        get { return object.frame.origin }
        set {
            var newFrame = object.frame
            newFrame.origin = newValue
            object.frame = newFrame
        }
    }
    
    var center: CGPoint {
        get { return CGPoint(x: object.frame.midX, y: object.frame.midY) }
        set {
            var newFrame = object.frame
            newFrame.origin.x = newValue.x - newFrame.size.width * 0.5
            newFrame.origin.y = newValue.y - newFrame.size.height * 0.5
            object.frame = newFrame
        }
    }
    
    var size: CGSize {
        get { return object.frame.size }
        set {
            var newFrame = object.frame
            newFrame.size = newValue
            object.frame = newFrame
        }
    }
    
    var frame: CGRect {
        get { return object.frame }
        set { object.frame = newValue }
    }
    
    var bounds: CGRect {
        get { return object.bounds }
        set { object.bounds = newValue }
    }
}
