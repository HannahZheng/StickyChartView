//
//  String + CaculateSize.swift
//  XGLive
//
//  Created by 郑晗 on 2021/8/30.
//

import UIKit

extension String: DuoboCompatible {}

extension Duobo where Object == String {
    /// 根据文字最大宽度计算文本高度
    func caculateHeightWithString(font: UIFont, maxWidth: CGFloat) -> CGSize {
        guard object.count > 0 else {
            return .zero
        }
        let attrDic = [NSAttributedString.Key.font: font]
        let size = CGSize(width: maxWidth, height: CGFloat.zero)
        var rect = object.boundingRect(with: size,
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     attributes: attrDic,
                                     context: nil)
        rect.size.height += font.xHeight
        return rect.size
    }
    /// 根据文字最大宽度、行间距、段落间距计算文本高度
    func caculateHeightWithString(font: UIFont, lineSpacing: CGFloat, paragrahSpacing: CGFloat? = nil, maxWidth: CGFloat) -> CGSize {
        guard object.count > 0 else {
            return .zero
        }
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = lineSpacing
        if let paraH = paragrahSpacing {
            paraStyle.paragraphSpacing = paraH
        }
        let attrDic = [NSAttributedString.Key.font: font,
                       NSAttributedString.Key.paragraphStyle: paraStyle]
        let size = CGSize(width: maxWidth, height: CGFloat.zero)
        var rect = object.boundingRect(with: size,
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     attributes: attrDic,
                                     context: nil)
        rect.size.height += font.xHeight
        return rect.size
    }
    /// 根据文本最大高度，计算文本宽度
    func caculateWidthWithString(font: UIFont, maxHeight: CGFloat) -> CGSize {
        guard object.count > 0 else {
            return .zero
        }
        let attrDic = [NSAttributedString.Key.font: font]
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight)
        let rect = object.boundingRect(with: size,
                                       options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     attributes: attrDic,
                                     context: nil)
        let width = ceil(rect.width)
        return CGSize(width: width, height: rect.height)
    }
    
//    func caculateWidthUsingAttributeString(font: UIFont) -> CGSize {
//        guard object.count > 0 else {
//            return .zero
//        }
//        let attrDic = [NSAttributedString.Key.font: font]
//        let attrStr = NSMutableAttributedString(string: object, attributes: attrDic)
//        return attrStr.size()
//    }
    /// 根据文本最大高度、行间距、段落间距计算文本宽度
    func caculateWidthWithString(font: UIFont, lineSpacing: CGFloat, paragrahSpacing: CGFloat? = nil, maxHeight: CGFloat) -> CGSize {
        guard object.count > 0 else {
            return .zero
        }
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = lineSpacing
        if let paraH = paragrahSpacing {
            paraStyle.paragraphSpacing = paraH
        }
        
        let attrDic = [NSAttributedString.Key.font: font,
                       NSAttributedString.Key.paragraphStyle: paraStyle]
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight)
        let rect = object.boundingRect(with: size,
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     attributes: attrDic,
                                     context: nil)
        return rect.size
    }
    
    func trim() -> String {
        let resultString = object.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return resultString
    }
    
    func trimAll() -> String {
        let nsStr = object as NSString
        let newStr = nsStr.replacingOccurrences(of: " ", with: "", options: .literal, range: NSRange.init(location: 0, length: nsStr.length))
        return newStr as String
//        return object.replacingOccurrences(of: " ", with: "", options: .literal, range: Range(NSRangeFromString(object), in: object))
    }
    
    /// 将输入的数字按照手机号码形式进行格式化
    func toMobileFormatter() -> String {
        var text = trimAll()
       
        if text.count <= 3 {
            return text
        }
        if text.count <= 7 {
            var temp = text
            temp.insert(" ", at: temp.index(temp.startIndex, offsetBy: 3))
            return temp
        }
        if text.count <= 10 {
            var temp = text
            temp.insert(" ", at: temp.index(temp.startIndex, offsetBy: 3))
            temp.insert(" ", at: temp.index(temp.startIndex, offsetBy: 8))
            return temp
        }
        if text.count > 11 {
            text = String(text.prefix(11))
        }
        return text.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d{4})", with: "$1 $2 $3", options: .regularExpression, range: text.startIndex..<text.endIndex)
    }
    
}

extension UILabel {
    static func willLabelWrapText(label: UILabel, maxWidth: CGFloat) -> Bool {
        let labelSize = label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        return labelSize.height > label.font.lineHeight
    }
}
