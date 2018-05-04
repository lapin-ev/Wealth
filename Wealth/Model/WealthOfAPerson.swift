//
//  WealthOfAPerson.swift
//  Wealth
//
//  Created by Jack Lapin on 5/4/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import Foundation

public protocol ChartApplicable: class {
    
    var totalValue: Double { get set }
    var ytdValue: Double { get set }
    
    var currency: String { get set }
    var chartData: [(key: Date, value: Double)]? { get set }
    var startDate: Date { get set }
}

final class WealthOfAPerson: ChartApplicable {
    
    var totalValue: Double
    var ytdValue: Double
    var currency: String
    var startDate: Date
    
    var chartData: [(key: Date, value: Double)]?
    
    init(currency: String, totalValue: Double, ytdValue: Double, startDate: Date) {
        self.currency = currency
        self.totalValue = totalValue
        self.ytdValue = ytdValue
        self.startDate = startDate
    }
    
}
