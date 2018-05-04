//
//  ViewController.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/6/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import UIKit
import Charts

final class ViewController: UIViewController {
    
    fileprivate let wealthData: Observable<ChartApplicable?> = Observable(nil)
    
    fileprivate enum CellType: Int {
        case summary, chart
        
        var cellIdentifier: String {
            get {
                switch self {
                case .summary:
                    return String(describing: SummaryCell.self)
                case .chart:
                    return String(describing: ChartCell.self)
                }
            }
        }
    }
    
    fileprivate var cellsToDisplay: [CellType] = [.summary, .chart]

    fileprivate lazy var dataProvider: DataProvider = {
        return DataProvider()
    }()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataProvider.getData(in: DateInterval(start: Date(), end: Date())) {
            switch $0 {
            case .success( let value ):
                self.wealthData.value = value
            case .failure( let error ):
                print(error)
            }
        }
        registerNibs()
    }
    
    private func registerNibs() {
        let summaryCellKey = String(describing: SummaryCell.self)
        tableView.register(
            UINib(nibName: summaryCellKey, bundle: nil),
            forCellReuseIdentifier: summaryCellKey
        )
       
        let chartCellKey = String(describing: ChartCell.self)
        tableView.register(
            UINib(nibName: chartCellKey, bundle: nil),
            forCellReuseIdentifier: chartCellKey
        )
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellsToDisplay[indexPath.section].cellIdentifier, for: indexPath) as! ChartAcceptingCell
        cell.configure(with: wealthData)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12 // padding between cells
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

extension ViewController: UITableViewDelegate { }
