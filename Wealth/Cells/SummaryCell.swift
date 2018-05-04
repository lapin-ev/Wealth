//
//  SummaryCell.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/21/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import UIKit

final class SummaryCell: ChartAcceptingCell {
    
    @IBOutlet private weak var totalCaption: UILabel!
    @IBOutlet private weak var totalValue: UILabel!
    
    @IBOutlet private weak var ytdCaption: UILabel!
    @IBOutlet private weak var ytdValue: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        totalValue.text = "-"
        ytdValue.text = "-"
    }
    
    override func paint(with data: ChartApplicable) {
        var currencySymbol = ""
        if data.currency == "GBP" {
            currencySymbol = "£"
        }
        let formatter = LargeValueFormatter()
        totalValue.text = currencySymbol + formatter.stringForValue(data.totalValue)
        
        if data.ytdValue < 0 {
            ytdValue.text = "↓" + formatter.stringForValue( -data.ytdValue)
            ytdCaption.text = "NET LOSS YTD".uppercased()
        } else {
            ytdValue.text = "↑" + formatter.stringForValue(data.ytdValue)
            ytdCaption.text = "NET INCOME YTD".uppercased()
        }
    }
    
}
