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
        var values = [ChartDataEntry]()
        
        data.forEach {
            values.append(ChartDataEntry(x: $0.key.timeIntervalSince1970, y: $0.value))
            print("\($0.key)" + "  \($0.value)")
        }

        let dataSet = WealthChartDataSet(values: values, label: nil)
        
        let chartData = LineChartData(dataSet: dataSet)
//        chartData.setValueTextColor(.white)
//        chartData.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        chartView.data = chartData
        for set in chartView.data!.dataSets as! [WealthChartDataSet] {
            set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
        }
        chartView.setNeedsDisplay()
    }
    
}
