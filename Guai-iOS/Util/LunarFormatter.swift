//
//  LunarFormatter.swift
//  xkb
//
//  Created by heqichang on 2/29/20.
//  Copyright © 2020 heqichang. All rights reserved.
//

import UIKit

/// 农历格式化器
class LunarFormatter {
    
    fileprivate let chineseCalendar = Calendar(identifier: .chinese)
    fileprivate let formatter = DateFormatter()
    fileprivate let lunarDays = ["初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九",
                                 "廿十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"]
    fileprivate let lunarMonths = ["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]
    
    init() {
        self.formatter.calendar = self.chineseCalendar
        self.formatter.dateFormat = "M"
    }
    
    /// 格式化农历日期
    ///
    /// - Parameters: from 要格式化的日期
    /// 
    /// - Returns: 格式化好的农历字符串，eg. 正月初一
    func string(from date: Date) -> String {
        
        var str = ""
        
        let monthString = self.formatter.string(from: date)
        if self.chineseCalendar.veryShortMonthSymbols.contains(monthString) {
            if let month = Int(monthString) {
                str += self.lunarMonths[month - 1]
            }
        } else {
            // 闰月后面格式化有 bis
            let month = self.chineseCalendar.component(.month, from: date)
            str += "闰"
            str += self.lunarMonths[month - 1]
        }
        
        let day = self.chineseCalendar.component(.day, from: date)
        str += self.lunarDays[day - 1]
        
        return str
    }
    
}


