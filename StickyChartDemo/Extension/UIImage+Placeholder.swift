//
//  UIImage+Placeholder.swift
//  BeiBei
//
//  Created by Han on 2023/8/23.
//

import UIKit

extension UIImage {
    static let placeholder = drawPlaceholdImage()
    static let color_placeholder = UIImage(color: .rgba(223, 223, 223, 1), size: CGSize(width: 100, height: 100))
    
    /// 绘制灰底带logo图， 默认logo居中， 若logo_top > 0 则logo的y坐标为按照logo_top
    static func drawPlaceholdImage(color: UIColor = UIColor.rgba(223, 223, 223, 1),
                                   size: CGSize = CGSize(width: 100, height: 100),
                                   logo_top: CGFloat = 0) -> UIImage? {
        // 创建图片上下文
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        // 绘制灰色背景
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        // 绘制 logo
        if let logoImage = R.image.empty_logo() {
            let logoSize = logoImage.size
            var logoRect = CGRect(x: (size.width - logoSize.width) / 2, y: (size.height - logoSize.height) / 2, width: logoSize.width, height: logoSize.height)
            if logo_top > 0 {
                logoRect.origin.y = logo_top
            }
            logoImage.draw(in: logoRect)
        }
        
        // 获取绘制结果并结束图片上下文
        let customImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return customImage
    }

}
