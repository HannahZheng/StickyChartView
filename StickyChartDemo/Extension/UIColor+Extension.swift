//
//  UIColor+Extension.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/17.
//

import UIKit

extension UIColor {
    /// 生成UIColor ：使用 AHEX
    /// 支持传入九位字符串  #99FFFFFF
    ///  七位字符串 #00FCFF  会转为 #FF00FCFF
    public convenience init?(AHEX: String) {
        if !AHEX.contains("#") {
            return nil
        }
        var ahex = AHEX
        if ahex.count == 7 {
            ahex = ahex.replacingOccurrences(of: "#", with: "#FF")
        }
        if ahex.count != 9 {
            return nil
        }
        
        ahex = ahex.replacingOccurrences(of: "#", with: "")
        
        // 将 AHEX 转为 HEXA
        let hexa = UIColor.moveFirstTwoToLastTwo(ahex)
//        printLog("将 AHEX 转为 HEXA : \(ahex) => \(hexa)")
        
        guard let c = Int(hexa, radix: 16) else { return nil }
        switch hexa.count {
        case 8:
            let r = CGFloat((c & 0xFF000000) >> 24) / 255
            let g = CGFloat((c & 0x00FF0000) >> 16) / 255
            let b = CGFloat((c & 0x0000FF00) >> 8) / 255
            let a = CGFloat(c & 0x000000FF) / 255
            self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        default:
            return nil
        }
    }
    
    /// hexstring 生成UIColor ：使用 HEXA，不支持 AHEX
    public convenience init?(hexString: String) {
        if hexString.count < 3 {
            return nil
        }
        var hex = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") {
            let h = hex.suffix(from: String.Index(utf16Offset: 1, in: hex))
            hex = String(h)
        } else if hex.hasPrefix("0X") {
            let h = hex.suffix(from: String.Index(utf16Offset: 2, in: hex))
            hex = String(h)
        }
        guard let c = Int(hex, radix: 16) else { return nil }
        switch hex.count {
        case 3: // RGB
            let r = (c >> 8 & 0xf) | (c >> 4 & 0x0f0)
            let g = (c >> 4 & 0xf) | (c & 0xf0)
            let b = ((c & 0xf) << 4) | (c & 0xf)
            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
        case 4: // ARGB
            let r = c >> 16 & 0xff
            let g = c >> 8 & 0xff
            let b = c & 0xff
            let a = c >> 24 & 0xff
            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 100.0)
        case 6: // RRGGBB
            let r = c >> 16 & 0xff
            let g = c >> 8 & 0xff
            let b = c & 0xff
            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
        case 8: // RRGGBBAA
            // 有问题
//            let r = c >> 24 & 0xff
//            let g = c >> 16 & 0xff
//            let b = c >> 8 & 0xff
//            let a = c & 0xff
//            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 100.0)
            let r = CGFloat((c & 0xFF000000) >> 24) / 255
            let g = CGFloat((c & 0x00FF0000) >> 16) / 255
            let b = CGFloat((c & 0x0000FF00) >> 8) / 255
            let a = CGFloat(c & 0x000000FF) / 255
            self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
            
        default:
            return nil
        }
    }
    /// 深浅模式颜色适配，如果不使用R.color.xxx，可考虑该方法
    public convenience init?(lightColor: UIColor?, darkColor: UIColor?) {
        if #available(iOS 13.0, *) {
            self.init { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    if let lc = lightColor {
                        return lc
                    }
                    fatalError("lightColor 不能为nil")
                case .dark:
                    if let dc = darkColor {
                        return dc
                    }
                    fatalError("darkColor 不能为nil")
                @unknown default:
                    if let lc = lightColor {
                        return lc
                    }
                    fatalError("lightColor 不能为nil")
                }
            }
            return
        }
        if let lc = lightColor {
            self.init(cgColor: lc.cgColor)
            return
        }
        return nil
    }
    // 深浅模式适配时，导航栏颜色不同时需要使用该方法，而不能直接使用R.color.xxx 或者 init?(lightColor: UIColor?, darkColor: UIColor?)
//    static func themeColor(light: UIColor, dark: UIColor, unspecified: UIColor) -> UIColor {
//        switch AppConfig.shared.theme {
//        case .light: return light
//        case .dark: return dark
//        default: return unspecified
//        }
//    }
    /// r g b 的取值均为 0-255
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    private static func moveFirstTwoToLastTwo(_ str: String) -> String {
        guard str.count >= 2 else { return str }
        
        let firstTwo = str.prefix(2)
        let remaining = str.suffix(str.count - 2)
        
        return String(remaining + firstTwo)
    }
}
