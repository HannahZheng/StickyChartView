//
//  TimeInterval+Ex.swift
//  BeiBei
//
//  Created by Jonhory on 2023/8/18.
//

import Foundation

extension TimeInterval {

    /// 显示年月日时分秒
    ///  今天 显示 时分秒
    func formatInterval() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        if Calendar.current.isDateInToday(date) {
            formatter.dateFormat = "HH:mm:ss"
        } else {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        return formatter.string(from: date)
    }
    
    func formatIntervalTo(_ dateFormat: Date.DateFormatterStyle = .mdhm) -> String {
        
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = dateFormat.stringFormat
        return formatter.string(from: date)
    }

}
