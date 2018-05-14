//
//  ChartAcceptingCell.swift
//  Wealth
//
//  Created by Jack Lapin on 5/3/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import UIKit

class ChartAcceptingCell: UITableViewCell {
    
    // MARK: CodeReview
    // Cell can not exist without these properties, so I would recommend to do it non-optional
    private var info: Observable<ChartApplicable?>?
    private var observationToken: String?
    
    func configure(with data: Observable<ChartApplicable?>) {
        self.info = data
        
        if let data = data.value {
            paint(with: data)
        }
        observationToken = data.onChange { [weak self] data in
            guard let data = data else { return }
            self?.paint(with: data)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        guard let info = info, let token = observationToken else {
            return
        }
        
        info.unsubscribe(with: token)
    }
    
    func paint(with data: ChartApplicable) {
        fatalError("Has to be implemented in subclass")
    }
    
}
