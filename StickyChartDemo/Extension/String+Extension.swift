//
//  String+Extension.swift
//  BeiBei
//
//  Created by Han on 2023/7/24.
//

import Foundation

extension Duobo where Object == String {
    var float: Float {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: object)?.floatValue ?? 0
    }
    
    var double: Double {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: object)?.doubleValue ?? 0
    }
    
    var int: Int {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: object)?.intValue ?? 0
    }
    
    func maxLengthString(maxCount: Int) -> String {
        let str = object.trimmingCharacters(in: .whitespacesAndNewlines)
        if str.count <= maxCount {
            return str
        }
        let startIndex = str.startIndex
        let endIndex = str.index(startIndex, offsetBy: maxCount)
        let temp = String(str[startIndex..<endIndex])
        return temp + "..."
    }
    
    /// 是否为可成功创建的url
    func isURLStringEncoded() -> Bool {
        guard object.count > 0 else {
            return false
        }
        return  URL(string: object) != nil
    }
    /// 先判断再编码
    func autoUrlEncoded() -> String {
        return object.duobo.isURLStringEncoded() ? object : object.duobo.urlEncoded()
    }
    
    /// 将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = object.addingPercentEncoding(withAllowedCharacters:
                                                                .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    /// 将编码后的url转换回原始的url
    func urlDecoded() -> URL? {
        let str =  object as NSString
        if let url = str.removingPercentEncoding {
            return URL(string: url)
        }
        return nil
    }
    
    /// 去掉反斜杠
    func replaceSlash() -> String {
        return object.replacingOccurrences(of: "\\", with: "")
    }
    /// 去除网络请求中的字符串中额外添加的转义
    func removeEncoding() -> String {
        let str = object.removingPercentEncoding ?? object
        return str
    }
}

extension Duobo where Object == String {
    func maskPhoneNumber() -> String {
        guard object.count > 7 else {
            return object
        }
        let startIndex = object.index(object.startIndex, offsetBy: 3)
        let endIndex = object.index(object.endIndex, offsetBy: -4)
        
        let maskedPart = String(repeating: "*", count: object.count - 7)
        let maskedPhoneNumber = object.replacingCharacters(in: startIndex..<endIndex, with: maskedPart)
        
        return maskedPhoneNumber
    }
    
    func maskName() -> String {
        guard object.count > 1 else {
            return object
        }
        let first = (object as NSString).substring(to: 1)
        let arr = Array(repeating: "*", count: object.count-1)
    
        return arr.reduce(first, {
            $0 + $1
        })
    }
    
    func maskIDNumber() -> String {
        guard object.count > 2 else {
            return object
        }
        let first = (object as NSString).substring(to: 1)
        let last = (object as NSString).substring(from: object.count-2)
        let arr = Array(repeating: "*", count: object.count-2)
        let result = arr.reduce(first, {
            $0 + $1
        }) + last
        return result
    }
}
