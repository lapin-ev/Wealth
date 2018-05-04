//
//  WealthChartDataSet.swift
//  Wealth
//
//  Created by Jack Lapin on 5/4/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import Foundation
import Charts

final class WealthChartDataSet: LineChartDataSet {
    
    override init(values: [ChartDataEntry]?, label: String?) {
        super.init(values: values, label: label)
     
        axisDependency = .left
        setColor(UIColor(red: 107/255, green: 23/255, blue: 102/255, alpha: 1))
        lineWidth = 1.5
        drawCirclesEnabled = false
        drawValuesEnabled = false
        fillAlpha = 0.26
        fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        drawCircleHoleEnabled = false
        
        let gradientColors = [
            ChartColorTemplates.colorFromString("#ffffff").cgColor,
            ChartColorTemplates.colorFromString("#C2207E").cgColor
        ]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        fillAlpha = 0.6
        fill = Fill(linearGradient: gradient, angle: 90)
        drawFilledEnabled = true
    }
    
    required init() {
        super.init()
    }
    
}
