//
//  UIImage+Blur.swift
//  BeiBei
//
//  Created by Jonhory on 2023/7/12.
//

import UIKit
import CoreImage

extension UIImageView {
    
    // let imageView = UIImageView(image: UIImage(named: "example-image"))
    // imageView.applyBlurEffect()
    /// 模糊半径
    func applyBlurEffect(blurRadius: CGFloat = 6) {
        // 创建 CIContext
        let ciContext = CIContext(options: nil)
        
        // 创建 CIImage
        guard let image = self.image, let ciImage = CIImage(image: image) else { return }
        
        // 创建 CIFilter（模糊滤镜）
        guard let filter = CIFilter(name: "CIGaussianBlur") else { return }
        
        // 设置滤镜参数
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        // 模糊半径
        filter.setValue(blurRadius, forKey: kCIInputRadiusKey)
        
        // 应用滤镜
        guard let outputImage = filter.outputImage else { return }
        
        // 渲染输出图像
        guard let outputCGImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        // 创建模糊后的 UIImage
        let blurredImage = UIImage(cgImage: outputCGImage)
        
        // 在 UIImageView 中显示模糊后的图片
        self.image = blurredImage
    }
}
