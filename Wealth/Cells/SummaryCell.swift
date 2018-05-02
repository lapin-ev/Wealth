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
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
