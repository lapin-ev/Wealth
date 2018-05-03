//
//  ChartAcceptingCell.swift
//  Wealth
//
//  Created by Jack Lapin on 5/3/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import UIKit

class ChartAcceptingCell: UITableViewCell {
    
    var inject: (() -> ChartApplicable?)?
    
    private var info: ChartApplicable?
    
    func configure(with data: ChartApplicable?) {
        self.info = data
    }
    
}
