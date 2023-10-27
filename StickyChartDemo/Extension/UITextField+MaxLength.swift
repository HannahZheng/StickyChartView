//
//  UITextField+MaxLength.swift
//  BeiBei
//
//  Created by Han on 2023/7/17.
//

import UIKit

extension Duobo where Object: UITextField {

    func limitMaxLength(_ maxLength: Int) {
        guard maxLength > 0 else {return}
        guard let text = object.text, text.isEmpty == false else {
            return
        }
        
        // /获取高亮部分
        let selectedRange = object.markedTextRange
        let pos = object.position(from: object.beginningOfDocument, offset: 0)

        /// 如果在变化中是高亮部分在变，就不要计算字符了
        if (selectedRange != nil) && (pos != nil) {
            return
        }
        
        if text.count >= maxLength {
            object.text = String(text.prefix(maxLength))
        }
    }
    
    func shouldChangeCharactersWithReplacementString(_ string: String, range: NSRange, maxCount: Int) -> Bool {
        if let c = string.cString(using: .utf8) {
            let isBackSpace = strcmp(c, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        if let text = object.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            return updatedText.count <= maxCount
        }
        return true
    }
}

extension Duobo where Object: UITextView {
    func limitMaxLength(_ maxLength: Int) {
        guard maxLength > 0 else {return}
        guard let text = object.text, text.isEmpty == false else {
            return
        }
        
        let selectedRange = object.markedTextRange
        let pos = object.position(from: object.beginningOfDocument, offset: 0)
    
        /// 如果在变化中是高亮部分在变，就不要计算字符了
        if (selectedRange != nil) && (pos != nil) {
            return
        }
        if object.text.count >= maxLength {
            object.text = String(object.text.prefix(maxLength))
        }
    }
    
    func shouldChangeCharactersWithReplacementString(_ string: String, range: NSRange, maxCount: Int) -> Bool {
        if let c = string.cString(using: .utf8) {
            let isBackSpace = strcmp(c, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        if let text = object.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            return updatedText.count <= maxCount
        }
        return true
    }
}
