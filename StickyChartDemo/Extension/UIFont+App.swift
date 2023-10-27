//
//  UIFont+App.swift
//  BeiBei
//
//  Created by Han on 2023/7/11.
//

import UIKit

enum AppFontName: String, CaseIterable {
    case medium        = "PingFangSC-Medium"
    case semibold      = "PingFangSC-Semibold"
    case light         = "PingFangSC-Light"
    case ultralight    = "PingFangSC-Ultralight"
    case regular       = "PingFangSC-Regular"
    case thin          = "PingFangSC-Thin"
}
extension UIFont: DuoboCompatible {}
extension Duobo where Object == UIFont {
    static func mediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func semiboldFont(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.semibold.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func lightFont(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func ultralightFont(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.ultralight.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
    }
    
    static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func thinFont(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.thin.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .thin)
    }
    
}
