//
//  DateExtension.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/4.
//

import Foundation

extension Date {
    static func chineseYearMonthDay(fromISO8601DateString dateString: String) -> String? {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = DateFormat.iso8601.rawValue
        guard let date: Date = formatter.date(from: dateString) else { return nil }
        formatter.dateFormat = DateFormat.chineseYearMonthDay.rawValue
        return formatter.string(from: date)
    }
}

enum DateFormat: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case chineseYearMonthDay = "yyyy年M月d日"
}


