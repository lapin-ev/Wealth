//
//  ChartCell.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/21/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import UIKit
import Charts

final class ChartCell: ChartAcceptingCell {

    @IBOutlet weak var chartView: WealthChart!
    
    override func paint(with data: ChartApplicable) {
        if let chartData = data.chartData {
            fillChart(with: chartData)
        }
    }
    
    private func fillChart(with data: [(key: Date, value: Double)]) {
        
        let now = Date().timeIntervalSince1970
        let hourSeconds: TimeInterval = 3600
        
        let from = now - (Double(100) / 2) * hourSeconds
        let to = now + (Double(100) / 2) * hourSeconds
        
        let values = stride(from: from, to: to, by: hourSeconds).map { (x) -> ChartDataEntry in
            let y = arc4random_uniform(30) + 50
            return ChartDataEntry(x: x, y: Double(y))
        }
        
        let set1 = WealthChartDataSet(values: values, label: nil)
        
        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        chartView.data = data
    }
    
}
