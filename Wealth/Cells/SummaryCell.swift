//
//  SummaryCell.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/21/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import UIKit

final class SummaryCell: ChartAcceptingCell {
    
    @IBOutlet weak var totalCaption: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    
    @IBOutlet weak var ytdCaption: UILabel!
    @IBOutlet weak var ytdValue: UILabel!
    

    override func configure(with data: ChartApplicable?) {
        super.configure(with: data)
        
        guard let data = data else { return }
        
        var currency = ""
        if data.currency == "GBP" {
            currency = "£"
        }
        totalValue.text = currency + data.totalValue.formatPoints()
        
        if data.ytdValue < 0 {
            ytdValue.text = "↓" + ( -data.ytdValue).formatPoints()
            ytdCaption.text = "NET LOSS YTD".uppercased()
        } else {
            ytdValue.text = "↑" + data.ytdValue.formatPoints()
            ytdCaption.text = "NET INCOME YTD".uppercased()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
