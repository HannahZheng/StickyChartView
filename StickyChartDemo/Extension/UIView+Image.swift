//
//  UIView+Image.swift
//  BeiBei
//
//  Created by Han on 2023/7/22.
//

import UIKit

extension Duobo where Object: UIView {
    func getImage(scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(object.bounds.size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        object.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }

}

extension Duobo where Object: CALayer {
    func getImage(scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(object.bounds.size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        object.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}

extension Duobo where Object: UIImageView {
    /// 用于设置导航栏背景图 ，通过原渐变背景视图，获取适合导航栏高度的渐变背景
    func getCropImage(rect: CGRect = CGRect(x: 0, y: 0, width: sWidth, height: statusBarHeight + 44), scale: CGFloat = 0) -> UIImage? {
        let ori_frame = object.frame
        
        object.frame = rect
        object.contentMode = .top
        let image = object.duobo.getImage(scale: scale)
        object.frame = ori_frame
        object.contentMode = .scaleToFill
        return image
    }
}
