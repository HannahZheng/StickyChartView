//
//  FitSize.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/17.
//

import Foundation
import UIKit

/// 使用 SwiftyFitsize 出现打包上传AppStore报错，故而临时自定义iPhone和iPad适配
public let screen_min_width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
/// 是否为iPad
public let device_isIpad = (UIDevice.current.userInterfaceIdiom == .pad)
/// iPad_min_ratio
public let iPad_min_ratio: CGFloat = screen_min_width / 768.0
/// 自适应宽高：iPad固定为1.2（比例调试后，发现这个比例对于扫描仪更适合，也可另行调整） device_isIpad ? 1.2 :
///  目前调整为同widthRatio
public let fitRatio =  screen_min_width / 375.0
/// 以手机屏幕375适应屏幕宽度，成比例调整
public let widthRatio = screen_min_width / 375.0
// public let heightRatio =
/// 个别页面UI在屏幕更小时高度需要微调，iPhone-667,iPad-1024
public let screenHeightThan667 = device_isIpad ? UIScreen.main.bounds.height > 1024.0 : UIScreen.main.bounds.height > 667.0

extension Int: DuoboCompatible {}
extension Double: DuoboCompatible {}
extension Float: DuoboCompatible {}
extension CGFloat: DuoboCompatible {}
extension CGSize: DuoboCompatible {}
extension CGPoint: DuoboCompatible {}
extension CGRect: DuoboCompatible {}
extension UIEdgeInsets: DuoboCompatible {}

extension Duobo where Object == Int {
    /// iPad 比例根据fitRatio固定或与屏幕宽度成比例，iPhone以屏幕宽度成比例调整
    var fit: CGFloat {
        floor(CGFloat(object) * fitRatio)
    }
    /// 小屏手机成比例调整，大屏手机固定大小
    var less: CGFloat {
        return fitRatio > 1 ? CGFloat(object) : floor(CGFloat(object) * fitRatio)
    }
    /// 尺寸成比例调整，无论是iPhone，还是iPad,无论是大屏还是小屏
    var widthFit: CGFloat {
        floor(CGFloat(object) * widthRatio)
    }
    
}

extension Duobo where Object == Double {
    var fit: CGFloat {
        floor(object * fitRatio)
    }
    var less: CGFloat {
        return fitRatio > 1 ? CGFloat(object) : floor(CGFloat(object) * fitRatio)
    }
    var widthFit: CGFloat {
        floor(CGFloat(object) * widthRatio)
    }
}

extension Duobo where Object == Float {
    var fit: CGFloat {
        floor(CGFloat(object) * fitRatio)
    }
    var less: CGFloat {
        return fitRatio > 1 ? CGFloat(object) : floor(CGFloat(object) * fitRatio)
    }
    var widthFit: CGFloat {
        floor(CGFloat(object) * widthRatio)
    }
}

extension Duobo where Object == CGFloat {
    /// iPad 比例根据fitRatio固定或与屏幕宽度成比例，iPhone以屏幕宽度成比例调整
    var fit: CGFloat {
        floor(object * fitRatio)
    }
    /// 小屏手机成比例调整，大屏手机固定大小
    var less: CGFloat {
        return fitRatio > 1 ? CGFloat(object) : floor(CGFloat(object) * fitRatio)
    }
    
//    var less: CGFloat {
//        switch device_isIpad {
//        case true: return floor(CGFloat(object) * iPad_min_ratio)
//        case false: return fitRatio > 1 ? CGFloat(object) : floor(CGFloat(object) * fitRatio)
//        }
//
//    }
    /// 尺寸成比例调整，无论是iPhone，还是iPad,无论是大屏还是小屏
    var widthFit: CGFloat {
        floor(CGFloat(object) * widthRatio)
    }
}

extension Duobo where Object == CGPoint {
    var fit: CGPoint {
        CGPoint(x: object.x.duobo.fit, y: object.y.duobo.fit)
    }
    var less: CGPoint {
        CGPoint(x: object.x.duobo.less, y: object.y.duobo.less)
    }
    
    var widthFit: CGPoint {
        CGPoint(x: object.x.duobo.widthFit, y: object.y.duobo.fit)
    }
}

extension Duobo where Object == CGSize {
    var fit: CGSize {
        CGSize(width: object.width.duobo.fit, height: object.height.duobo.fit)
    }
    var less: CGSize {
        CGSize(width: object.width.duobo.less, height: object.height.duobo.less)
    }
    var widthFit: CGSize {
        CGSize(width: object.width.duobo.widthFit, height: object.height.duobo.fit)
    }
}

extension Duobo where Object == CGRect {
    var fit: CGRect {
        CGRect(x: object.minX.duobo.fit, y: object.minY.duobo.fit, width: object.width.duobo.fit, height: object.height.duobo.fit)
    }
    var less: CGRect {
        CGRect(x: object.minX.duobo.less, y: object.minY.duobo.less, width: object.width.duobo.less, height: object.height.duobo.less)
    }
    var widthFit: CGRect {
        CGRect(x: object.minX.duobo.widthFit, y: object.minY.duobo.fit, width: object.width.duobo.widthFit, height: object.height.duobo.fit)
    }
}

extension Duobo where Object == UIEdgeInsets {
    var fit: UIEdgeInsets {
        UIEdgeInsets(top: object.top.duobo.fit, left: object.left.duobo.fit, bottom: object.bottom.duobo.fit, right: object.right.duobo.fit)
    }
    var less: UIEdgeInsets {
        UIEdgeInsets(top: object.top.duobo.less, left: object.left.duobo.less, bottom: object.bottom.duobo.less, right: object.right.duobo.less)
    }
    var widthFit: UIEdgeInsets {
        UIEdgeInsets(top: object.top.duobo.widthFit, left: object.left.duobo.widthFit, bottom: object.bottom.duobo.widthFit, right: object.right.duobo.widthFit)
    }
}
