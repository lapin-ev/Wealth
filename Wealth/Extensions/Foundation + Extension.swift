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
