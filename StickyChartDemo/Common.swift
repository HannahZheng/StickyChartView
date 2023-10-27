//
//  Common.swift
//  BeiBei
//
//  Created by Jonhory on 2023/2/28.
//

import Foundation
import UIKit

// 获取打印的文件名、打印行数、打印函数
public func printLog(_ msg: Any, file: NSString = #file, line: Int = #line, fn: String = #function) {
#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    
    let string = "\n \(fileName): (\(line)) \(fn) \n \(msg) \n\n-------------"
    print(string)
#endif
}

public func deinitLog(_ msg: Any) {
    printLog(msg)
}

/// 生成随机字符串，固定长度
func randomStr(_ length: Int = 50) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var randomString = ""
    
    for _ in 0..<length {
        let randomIndex = Int.random(in: 0..<letters.count)
        let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
        randomString.append(randomCharacter)
    }
    return randomString
}

/// 生成随机字符串，输入最大长度
func randomStrMaxLength(_ max: Int = 50) -> String {
    randomStr(Int.random(in: 0..<max))
}

/// 随机生成繁体中文字符串，length为最大长度
func randomChineseString(length: Int) -> String {
    var result = ""
    for _ in 0..<Int.random(in: 0..<length) {
        if let randomUnicodeScalar = UnicodeScalar(Int.random(in: 0x4E00...0x9FA5)) {
            result.append(Character(randomUnicodeScalar))
        }
    }
    return result
}

/// 获取底部的安全距离，全面屏手机为34pt，非全面屏手机为0pt
let bottomSafeAreaHeight: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0

/// 底部tabBar栏高度（不包含安全区，即：在 iphoneX 之前的手机）
let tabBarHeightAbsolutely: CGFloat = 49.0

/// 底部导航栏高度（包括安全区），一般使用这个值
let tabBarHeight: CGFloat = bottomSafeAreaHeight + tabBarHeightAbsolutely

let statusBarManager: UIStatusBarManager? = UIApplication.shared.windows.first?.windowScene?.statusBarManager

/// 获取状态栏的高度，全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt
let statusBarHeight: CGFloat = statusBarManager?.statusBarFrame.size.height ?? 44.0

/// 本项目中， statusBarHeight + 导航栏一行高40
let navBarHeight: CGFloat = statusBarHeight + 40

let sWidth: CGFloat = UIScreen.main.bounds.width
let sHeight: CGFloat = UIScreen.main.bounds.height



