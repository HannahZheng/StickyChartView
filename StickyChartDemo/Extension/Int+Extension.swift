//
//  Int+Extension.swift
//  BeiBei
//
//  Created by Han on 2023/8/21.
//

import Foundation

extension Duobo where Object == Int {
    func toString(isNormal: Bool = false) -> String {
        guard isNormal == false else {
            return "\(object)"
        }
         if object < 1000 {
            return "\(object)"
        } else if object < 10000 {
            let num = Double(object) * 0.001
            var string = String(format: "%.2fk", num)
            if string.contains(".00") {
                string = String(format: "%.0fk", num)
            }
            return string
        } else {
            let num = Double(object) * 0.0001
            var string = String(format: "%.2fw", num)
            if string.contains(".00") {
                string = String(format: "%.0fw", num)
            }
            return string
        }
        
    }
    
    func toWString() -> String {
      if object >= 10000 {
          let num = Double(object) * 0.0001
          var string = String(format: "%.2fw", num)
          if string.contains(".00") {
              string = String(format: "%.0fw", num)
          }
          return string
        }
        return "\(object)"
    }
    
    func toLikeString() -> String {
        if object < 1 {
            return "首赞"
        } else {
          return self.toString()
        }
        
    }
    
    func toTimeHmsStr() -> String {
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        timeFormatter.zeroFormattingBehavior = .pad

        if let formattedString = timeFormatter.string(from: TimeInterval(object)) {
            return formattedString
        }
        return "\(object)"
    }
}
