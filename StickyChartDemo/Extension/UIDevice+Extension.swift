//
//  UIDevice+Extension.swift
//  BeiBei
//
//  Created by Jonhory on 2023/7/12.
//

import Foundation
import UIKit

extension UIDevice {
    
    class func isPad() -> Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class func isPhone() -> Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    /// 获取设备具体详细的型号
    /// iPhone9,1
    static func modelName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {return identifier}
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
