//
//  UIButon+ImagePosition.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/17.
//

import UIKit
extension UIButton {
    enum ImagePosition {
        case top, left, right, bottom
    }
}

extension Duobo where Object: UIButton {
    
    /// 设置按钮标题和图片位置，以及间隔
    /// - Parameters:
    ///   - position: 图片的位置 在上，在下，在左，在右
    ///   - margin: 图片和标题之间的间距
    func resetImagePosition(_ position: UIButton.ImagePosition, margin: CGFloat) {
        guard let imgview = object.imageView, let titleL = object.titleLabel else { return }
        let imgWidth = imgview.bounds.size.width
        let imgHeight = imgview.bounds.size.height
        var labWidth = titleL.bounds.size.width
        let labHeight = titleL.bounds.size.height
        let textSize = ((titleL.text ?? "") as NSString).size(withAttributes: [.font: titleL.font ?? UIFont.systemFontSize])
        let frameSize = CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
        if labWidth < frameSize.width {
            labWidth = frameSize.width
        }
        let kMargin = margin * 0.5
        switch position {
        case .left:// 图左字右
            object.imageEdgeInsets = UIEdgeInsets(top: 0, left: -kMargin, bottom: 0, right: kMargin)
            object.titleEdgeInsets = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: -kMargin)
        case .right:// 图右字左
            object.imageEdgeInsets = UIEdgeInsets(top: 0, left: labWidth + kMargin, bottom: 0, right: -labWidth - kMargin)
            object.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imgWidth - kMargin, bottom: 0, right: imgWidth + kMargin)
        case .top:// 图上字下
            object.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: labHeight + margin, right: -labWidth)
            object.titleEdgeInsets = UIEdgeInsets(top: imgHeight + margin, left: -imgWidth, bottom: 0, right: 0)
        case .bottom:// 图下字上
            object.imageEdgeInsets = UIEdgeInsets(top: labHeight + margin, left: 0, bottom: 0, right: -labWidth)
            object.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imgWidth, bottom: imgHeight + margin, right: 0)
        }
        
    }
    /// 生成纯色背景带圆角和边框的背景图
    func setBackgroundColor(_ color: UIColor, cornerRadius: CGFloat = 0, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear, for state: UIControl.State) {
        var img: UIImage?
        if borderWidth <= 0 {
            img = UIImage(color: color, size: object.frame.size, cornerRadius: cornerRadius)
        } else {
            img = UIImage(color: color, size: object.frame.size, cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor)
        }
        object.setBackgroundImage(img, for: state)
    }
    
    /// 对于调整图片位置的按钮，不要使用该方法, 采用设置高亮状态下的图片 button.setImage(icon, for: .highlighted)
    func cancleHighlighted() {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.automaticallyUpdateForSelection = false
            object.configuration = config
        } else {
            object.adjustsImageWhenHighlighted = false
//            object.isHighlighted = false
        }
    }
}
