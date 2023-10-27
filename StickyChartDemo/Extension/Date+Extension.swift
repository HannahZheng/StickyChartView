//
//  Date+Extension.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/29.
//

import Foundation

extension Date: DuoboCompatible {}

extension Date {
    public enum DateComponentType {
        case second, minute, hour, day, weekday, weekdayOrdinal, week, month, year
    }
}

public extension Duobo where Object == Date {
    func component(_ component: Date.DateComponentType) -> Int? {
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekOfYear, .hour, .minute, .second, .weekday, .weekdayOrdinal, .weekOfYear], from: object)
       
        switch component {
        case .second:
            return components.second
        case .minute:
            return components.minute
        case .hour:
            return components.hour
        case .day:
            return components.day
        case .weekday:
            return components.weekday
        case .weekdayOrdinal:
            return components.weekdayOrdinal
        case .week:
            return components.weekOfYear
        case .month:
            return components.month
        case .year:
            return components.year
        }
    }
  
    var isToday: Bool {
        guard let day = component(.day),
              let month = component(.month),
              let year = component(.year)
        else { return false }
//        if fabs(object.timeIntervalSinceNow) >= 60 * 60 * 24 { return false }
        return day == Date().duobo.component(.day) && month == Date().duobo.component(.month) && year == Date().duobo.component(.year)
    }
    
    func isSameDay(_ pare: Date = Date()) -> Bool {
        guard let day = component(.day),
              let month = component(.month),
              let year = component(.year)
        else { return false }
//        if fabs(object.timeIntervalSinceNow) >= 60 * 60 * 24 { return false }
        return day == pare.duobo.component(.day) && month == pare.duobo.component(.month) && year == pare.duobo.component(.year)
    }
    
    var isYesterday: Bool {
        return add(component: .day, offset: 1).duobo.isToday
    }
    
    var isCurrentMonth: Bool {
        let currentDate = Date()
        guard let currentYear = currentDate.duobo.component(.year),
              let currentMonth = currentDate.duobo.component(.month),
              let year = object.duobo.component(.year),
              let month = object.duobo.component(.month) else {
            return false
        }
        
        return currentYear != year || currentMonth == month
        
    }
    /// 从当前时间偏离的小时一致，分钟数未after 秒数为0
    func getAfterCurrentMinutes(_ after: Int = 5) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: object)
        guard let minute = components.minute
        else { return object }
        
        components.minute = minute + after
        components.second = 0
        let date = Calendar.current.date(from: components)
        return date ?? object
    }
    func add(component: Date.DateComponentType, offset: Int) -> Date {
        var dateComp = DateComponents()
        switch component {
        case .second:
            dateComp.second = offset
        case .minute:
            dateComp.minute = offset
        case .hour:
            dateComp.hour = offset
        case .day:
            dateComp.day = offset
        case .weekday:
            dateComp.weekday = offset
        case .weekdayOrdinal:
            dateComp.weekdayOrdinal = offset
        case .week:
            dateComp.weekOfYear = offset
        case .month:
            dateComp.month = offset
        case .year:
            dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: object) ?? object
    }
    func string(with format: String, timeZone: TimeZone = TimeZone.current, locale: Locale = Locale.current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.string(from: object)
    }
    func string(for formatterStyle: Date.DateFormatterStyle = .ymdhms) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatterStyle.stringFormat
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter.string(from: object)
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    func getMilliStamp() -> String {
        let timeInterval: TimeInterval = object.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    /// 纳秒时间戳 - 19位
    func getNanoStamp() -> String {
        let timeInterval = object.timeIntervalSince1970
        let nanosecond = CLongLong(round(timeInterval * pow(10, 9)))
        return "\(nanosecond)"
    }
    /// 一月
    func getChineseMonth() -> String {
        let month = Calendar.current.component(.month, from: object)
        let months = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"]
        return months[month-1] + "月"
    }
}

/*
 
 var date = Date.from("2023", formatterStyle: .year) ?? Date()
 var calendar = Calendar.current
 calendar.locale = Locale(identifier: "Asia/Shanghai")
 let result = calendar.range(of: .day, in: .month, for: date)
 printLog(result)
 printLog(result?.first)
 printLog(result?.last)
 
 //很有意思的startOfDay，如果date是Date()或者包含了年月日时分秒，返回的是当天凌晨;如果date包含年月，
 let start = calendar.startOfDay(for: date)
 printLog(start.duobo.string(for: .ymdhms))
 
 var components = DateComponents()
 components.month = 1
 components.second = -1
 let end = calendar.date(byAdding: components, to: date)
 printLog(end?.duobo.string())
 
 */

public extension Date {
    /// 指定年月的开始日期
    static func startOfMonth(year: Int, month: Int) -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps) ?? Date()
        return startDate
    }
     
    /// 指定年月的结束日期
    static func endOfMonth(year: Int, month: Int, returnEndTime: Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
         
        let endOfYear = calendar.date(byAdding: components,
                                      to: startOfMonth(year: year, month: month)) ?? Date()
        return endOfYear
    }
    
    /// 指定年月日的开始日期
    static func startOfDay(year: Int, month: Int, day: Int) -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        startComps.day = day
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps) ?? Date()
        return startDate
    }
    
    /// 指定年月日的结束日期
    static func endOfDay(year: Int, month: Int, day: Int) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.second = -1
       
        let endDate = calendar.date(from: components) ?? Date()
        return endDate
    }
    
    /// 本年开始日期
    static func startOfCurrentYear() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year]), from: date)
        let startOfYear = calendar.date(from: components) ?? Date()
        return startOfYear
    }
     
    /// 本年结束日期
    static func endOfCurrentYear(returnEndTime: Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.year = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
         
        let endOfYear = calendar.date(byAdding: components, to: startOfCurrentYear()) ?? Date()
        return endOfYear
    }
    
    /// 本月开始日期
    static func startOfCurrentMonth() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        let startOfMonth = calendar.date(from: components) ?? Date()
        return startOfMonth
    }
     
    /// 本月结束日期
    static func endOfCurrentMonth(returnEndTime: Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
         
        let endOfMonth =  calendar.date(byAdding: components, to: startOfCurrentMonth()) ?? Date()
        return endOfMonth
    }
}

public extension Date {
    /// 获取当天是星期中的的第几天
  static func getTodayIndex() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)

        // 因为星期天是一周的第一天，所以你可能需要根据需要将星期天（1）转换为7
        let adjustedWeekday = (weekday == 1) ? 7 : (weekday - 1)
        return adjustedWeekday
    }
}

public extension Date {
    static func fromToGMT8(_ string: String, formatterStyle: DateFormatterStyle = .ymdhms) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formatterStyle.stringFormat
        formatter.locale = Locale(identifier: "Asia/Shanghai")
        // 使用它不对 差8小时
//        if let zone = TimeZone(secondsFromGMT: 8) {
//            formatter.timeZone = zone
//        }
        
//        if let zone = TimeZone.init(abbreviation: "GMT+0800") {
//            formatter.timeZone = zone
//        }
        
        return formatter.date(from: string)
    }
    
    static func from(_ string: String, format: String, timeZone: TimeZone = .current, locale: Locale = .current) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.date(from: string)
    }
    
    static func from(timestamp: Double) -> (String) -> String {
        let date = Date(timeIntervalSince1970: timestamp / 1000)
        return { format in
            return date.duobo.string(with: format)
        }
    }
    
    static func from(timestamp: Double) -> (Date.DateFormatterStyle) -> String {
        let date = Date(timeIntervalSince1970: timestamp / 1000)
        return { style in
            return date.duobo.string(for: style)
        }
    }
    
    static func from(_ string: String, formatterStyle: Date.DateFormatterStyle) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formatterStyle.stringFormat
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter.date(from: string)
    }
}

extension Date {
    public enum DateFormatterStyle {
        /// "yyyy"
        case year
        /// "yyyy-MM"
        case yearMonth
        /// "MM-dd"
        case monthDay
        /// "yyyy-MM-dd"
        case date
        /// HH:mm
        case hm
        /// "HH:mm:ss"
        case hms
        /// "mm:ss"
        case ms
        /// "MM-dd HH:mm"
        case mdhm
        /// "yyyy-MM-dd HH:mm"
        case ymdhm
        /// "yyyy-MM-dd HH:mm:ss"
        case ymdhms
        /// "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
        case ymdhsss
        /// A custom date format string
        case custom(String)
        
        var stringFormat: String {
            switch self {
            case .year: return "yyyy"
            case .yearMonth: return "yyyy-MM"
            case .monthDay: return "MM-dd"
            case .date: return "yyyy-MM-dd"
            case .ms: return "mm:ss"
            case .hm: return "HH:mm"
            case .hms: return "HH:mm:ss"
            case .mdhm: return "MM-dd HH:mm"
            case .ymdhm: return "yyyy-MM-dd HH:mm"
            case .ymdhms: return "yyyy-MM-dd HH:mm:ss"
            case .ymdhsss: return "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
            case .custom(let customFormat): return customFormat
            }
        }
    }
}
