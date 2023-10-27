//
//  Color.swift
//  BeiBei
//
//  Created by Jonhory on 2023/7/7.
//

import Foundation
import UIKit

extension  UIColor {
     // 返回随机颜色
     static func randomColor() -> UIColor {
         let red =  CGFloat(Int.random(in: 0...256))/255.0
         let green = CGFloat(Int.random(in: 0...256))/255.0
         let blue = CGFloat(Int.random(in: 0...256))/255.0
         return  UIColor(red: red, green: green, blue: blue, alpha: 1.0)
     }
}
