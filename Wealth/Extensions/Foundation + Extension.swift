//
//  Foundation + Extension.swift
//  Wealth
//
//  Created by Jack Lapin on 4/24/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension Date {
    
    public var startOfQuarter: Date {
        let startOfMonth = Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.year, .month], from: Calendar.current.startOfDay(for: self)))!
        
        var components = Calendar.current.dateComponents([.month, .day, .year], from: startOfMonth)
        
        let newMonth: Int
        switch components.month! {
        case 1,2,3: newMonth = 1
        case 4,5,6: newMonth = 4
        case 7,8,9: newMonth = 7
        case 10,11,12: newMonth = 10
        default: newMonth = 1
        }
        components.month = newMonth
        return Calendar.current.date(from: components)!
    }
    
    public var startOfYear: Date {
        let startOfYear = Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.year], from: Calendar.current.startOfDay(for: self)))!
        let components = Calendar.current.dateComponents([.month, .day, .year], from: startOfYear)
        return Calendar.current.date(from: components)!
    }
}
