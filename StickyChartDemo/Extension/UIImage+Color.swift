//
//  UIImage+Color.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/17.
//

import UIKit

extension UIImage: DuoboCompatible {}

extension Duobo where Object == UIImage {
    /// 图片添加圆角
    func applyRadius(_ radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: object.size)
        let img = UIImage(size: object.size) { ctx in
            let path = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
            ctx.addPath(path)
            ctx.clip()
            self.object.draw(in: rect)
        }
        return img
    }
    
    /// 快捷生成渐变色图片，仅支持2个颜色渐变，该项目中主要用于导航栏
    static func customGradient(start_cl: UIColor,
                               end_cl: UIColor,
                               start_loc: CGFloat = 0,
                               end_loc: CGFloat = 1,
                               start_p: CGPoint = CGPoint(x: 0.5, y: 0),
                               end_p: CGPoint = CGPoint(x: 0.5, y: 1),
                               size: CGSize) -> UIImage? {
        let img = UIImage(linearColors: { _ in return [(start_cl, start_loc), (end_cl, end_loc)] }, size: size, start: start_p, end: end_p)
        return img
        
    }
    /// 快捷生成渐变色图片，支持多个颜色渐变 默认3个颜色渐变
    static func customGradient(colors: [UIColor] = [.rgba(222, 236, 255, 1), .rgba(232, 253, 255, 1), .rgba(232, 253, 255, 0)],
                               locations: [CGFloat] = [0, 0.5, 1],
                               start_p: CGPoint = CGPoint(x: 0.5, y: 0),
                               end_p: CGPoint = CGPoint(x: 0.5, y: 1),
                               size: CGSize) -> UIImage? {
        guard colors.count > 0, locations.count > 0, colors.count == locations.count else {
            printLog("❌ colors 需要与 locations数量一致，且都不为空")
            return nil
        }
        
        let img = UIImage(linearColors: { _ in
            var arr: [(UIColor, CGFloat)] = []
            for (idx, cl) in colors.enumerated() {
                arr.append((cl, locations[idx]))
            }
            return arr
        }, size: size, start: start_p, end: end_p)
        return img
    }
    
    /// 图片缩放
    func getImage(scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: object.size.width * scale, height: object.size.height * scale), false, 0.0)
        object.draw(in: CGRect(origin: .zero, size: CGSize(width: object.size.width * scale, height: object.size.height * scale)))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

extension UIImage {
    /// 在size大小CGContext画布中，根据modiy闭包来操作画布
    /// - Parameters:
    ///   - size: 图像画布大小
    ///   - actions: 操作画布---block(CGContext)
    /// - Returns: 生成的`UIImage`
    convenience init?(size: CGSize, actions: @escaping (CGContext) -> Void) {
        var img: UIImage?
        let scale = UIScreen.main.scale
        let f = UIGraphicsImageRendererFormat.default()
        f.scale = scale
        if #available(iOS 12.0, *) {
            f.preferredRange = .extended
        } else {
            f.prefersExtendedRange = true
        }
        let render = UIGraphicsImageRenderer(size: size, format: f)
        img = render.image(actions: { c in
            actions(c.cgContext)
        })
        if let i = img, let cg = i.cgImage {
            self.init(cgImage: cg, scale: i.scale, orientation: i.imageOrientation)
        } else {
            return nil
        }
    }
    
    /// 颜色 -> 纯色图像
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小 默认 CGSize(width: 1, height: 1)
    ///   - cornerRadius: 图片圆角大小
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), cornerRadius: CGFloat = 0) {
        let colorSize = UIColorImageCache.ColorSize(color: color, size: size, cornerRadius: cornerRadius)
        let cacheImg = UIColorImageCache.shared.imageFor(colorSize: colorSize)
        guard cacheImg == nil else {
            self.init(cgImage: cacheImg!.cgImage!, scale: cacheImg!.scale, orientation: cacheImg!.imageOrientation)
            return
        }
        let rect = CGRect(origin: .zero, size: size)
        let build: (CGContext) -> Void = { context in
            context.setFillColor(color.cgColor)
            if cornerRadius > 0 {
                let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
                path.addClip()
                path.fill()
            } else {
                context.fill(rect)
            }
        }
        if let img = UIImage(size: size, actions: build), let cg = img.cgImage {
            UIColorImageCache.shared.setImage(img, for: colorSize)
            self.init(cgImage: cg, scale: img.scale, orientation: img.imageOrientation)
        } else {
            return nil
        }
    }
    
    /// 生成带边框和圆角纯色图像
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 图片大小
    ///   - cornerRadius: 圆角
    ///   - borderWidth: 线宽
    ///   - borderColor: 边框颜色
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), cornerRadius: CGFloat = 0, borderWidth: CGFloat = 1, borderColor: UIColor = .black) {
        let colorSize = UIColorImageCache.ColorSize(color: color, size: size, cornerRadius: cornerRadius)
        let cacheImg = UIColorImageCache.shared.imageFor(colorSize: colorSize)
        guard cacheImg == nil else {
            self.init(cgImage: cacheImg!.cgImage!, scale: cacheImg!.scale, orientation: cacheImg!.imageOrientation)
            return
        }
        let rect = CGRect(origin: .zero, size: size)
        let build: (CGContext) -> Void = { context in
            context.setFillColor(color.cgColor)
            if cornerRadius > 0 {
                let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
                path.addClip()
                path.fill()
                path.lineWidth = borderWidth
                context.setStrokeColor(borderColor.cgColor)
                path.stroke()
            } else {
                context.fill(rect)
            }
           
        }
        if let img = UIImage(size: size, actions: build), let cg = img.cgImage {
            UIColorImageCache.shared.setImage(img, for: colorSize)
            self.init(cgImage: cg, scale: img.scale, orientation: img.imageOrientation)
        } else {
            return nil
        }
    }
    
    /// 线性颜色渐变图像
    ///
    /// - Parameters:
    ///   - linearColors: (颜色, 起始点)数组 注意：起始点范围(0~1.0)
    ///   - size: 大小
    ///   - start: 起始点(起点所在size中的x，y的百分比)
    ///   - end: 结束点(起点所在size中的x，y的百分比)
    convenience init?(linearColors: (CGSize) -> ([(UIColor, CGFloat)]), size: CGSize, start: CGPoint = .zero, end: CGPoint = CGPoint(x: 1, y: 0)) {
        guard size != .zero else {
            return nil
        }
        let colors = linearColors(size)
        if colors.count == 1 {
            self.init(color: colors[0].0, size: size)
            return
        }
        guard !colors.isEmpty else {
            return nil
        }
        let build: (CGContext) -> Void = { context in
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let initial: ([CGFloat], [CGFloat]) = ([], [])
            let (colorComponents, locations) = colors.map({ tupe -> ([CGFloat], CGFloat)? in
                guard let colorComponents = tupe.0.cgColor.components else {
                    return nil
                }
                return (colorComponents, tupe.1)
            }).reduce(initial, { (result, signle) -> ([CGFloat], [CGFloat]) in
                    var temp = result
                    if let signle = signle {
                        temp.0.append(contentsOf: signle.0)
                        temp.1.append(signle.1)
                    }
                    return temp
                })
            let s = CGPoint(x: size.width * start.x, y: size.height * start.y)
            let e = CGPoint(x: size.width * end.x, y: size.height * end.y)
            if let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: locations, count: locations.count) {
                context.drawLinearGradient(gradient, start: s, end: e, options: .drawsAfterEndLocation)
            }
        }
        guard let img = UIImage(size: size, actions: build),
            let cg = img.cgImage else {
                return nil
        }
        self.init(cgImage: cg, scale: img.scale, orientation: img.imageOrientation)
    }
    
}

/*--------------------------private--------------------------*/
/// 纯色图像缓存
 struct UIColorImageCache {
    struct ColorSize: CustomStringConvertible {
        var description: String {
            let width = size.width
            let height = size.height
            return "color:\(color) width:\(width) height:\(height) cornerRadius:\(cornerRadius)"
        }
        let color: UIColor
        let size: CGSize
        let cornerRadius: CGFloat
        init(color: UIColor, size: CGSize, cornerRadius: CGFloat) {
            self.color = color
            self.size = size
            self.cornerRadius = cornerRadius
        }
    }
    static let shared = UIColorImageCache()
    private let cache: NSCache<NSString, UIImage>
    private init() {
        cache = NSCache()
    }
    func imageFor(colorSize: ColorSize) -> UIImage? {
        return cache.object(forKey: colorSize.description as NSString)
    }
    func setImage(_ image: UIImage, for colorSize: ColorSize) {
        cache.setObject(image, forKey: colorSize.description as NSString)
    }
    
     func removeCache() {
        cache.removeAllObjects()
    }
}
