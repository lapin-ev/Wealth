//
//  WealthChart.swift
//  Wealth
//
//  Created by Jack Lapin on 5/4/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import Foundation
import Charts

final class WealthChart: LineChartView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        chartDescription?.enabled = false
        
        dragEnabled = false
        setScaleEnabled(false)
        pinchZoomEnabled = false
        highlightPerDragEnabled = false
        
        backgroundColor = .white
        
        legend.enabled = false
        
        let xAxis = self.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 121/255, green: 120/255, blue: 122/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 3600
        xAxis.valueFormatter = DateValueFormatter()
        
        let rightAxis = self.rightAxis
        rightAxis.labelPosition = .outsideChart
        rightAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        rightAxis.granularityEnabled = true
        rightAxis.drawGridLinesEnabled = true
        rightAxis.gridLineDashLengths = [3.0]
        rightAxis.drawAxisLineEnabled = false
        rightAxis.yOffset = -9
        rightAxis.labelTextColor = UIColor(red: 121/255, green: 120/255, blue: 122/255, alpha: 1)
        rightAxis.valueFormatter = LargeValueFormatter()
        
        leftAxis.enabled = false
        
        legend.form = .line
        
        animate(xAxisDuration: 1.5)
    }
    
}
