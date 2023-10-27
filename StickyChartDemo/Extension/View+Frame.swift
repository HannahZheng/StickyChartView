//
//  View+Frame.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/17.
//

import UIKit

extension UIView {
    @discardableResult
    static func + (lhs: UIView, rhs: UIView) -> UIView {
        lhs.addSubview(rhs)
        return lhs
    }
}

extension UIView: DuoboCompatible {}

extension Duobo where Object: UIView {
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
            object.center = CGPoint(x: newValue, y: object.frame.midY)
        }
    }
    
    var centerY: CGFloat {
        get { return object.frame.midY }
        set {
            object.center = CGPoint(x: object.frame.midX, y: newValue)
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
        get { return object.center }
        set {
            object.center = newValue
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
