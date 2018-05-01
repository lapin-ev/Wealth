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

    fileprivate lazy var dataProvider: DataProvider = {
        return DataProvider()
    }()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    
    
    @IBAction func reload(_ sender: Any) {
        let dataProvider = DataProvider()
        dataProvider.getData(in: DateInterval(start: Date(), end: Date())) {
            switch $0 {
            case .success( let values ):
                print(values)
            case .failure( let error ):
                print(error)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataProvider = DataProvider()
        dataProvider.getData(in: DateInterval(start: Date(), end: Date())) {
            switch $0 {
            case .success( let values ):
                print(values)
            case .failure( let error ):
                print(error)
            }
        }
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // padding between cells
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
}

extension ViewController: UITableViewDelegate {
    
}
