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

    @IBOutlet private weak var chartView: WealthChart!
    
    override func paint(with data: ChartApplicable) {
        if let chartData = data.chartData, chartData.count > 0 {
            fillChart(with: chartData)
        }
    }
    
    private func fillChart(with data: [(key: Date, value: Double)]) {
        var values = [ChartDataEntry]()
        data.forEach { values.append(ChartDataEntry(x: $0.key.timeIntervalSince1970, y: $0.value)) }
        chartView.data = LineChartData(dataSet: WealthChartDataSet(values: values, label: nil))
    }
    
}
