//
//  DataProvider.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/21/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import Foundation
import UIKit
import CoreData



protocol ChartApplicable: class { //TODO: Name??
    
    var totalValue: Double { get set }
    var ytdValue: Double { get set }
    
    var currency: String { get set }
    var chartData: [(key: Date, value: Double)]? { get set }
    var startDate: Date { get set }
}

class WealthOfAPerson: ChartApplicable {
    
    var totalValue: Double
    var ytdValue: Double
    var currency: String
    var startDate: Date
    
    var chartData: [(key: Date, value: Double)]?
    
    init(currency: String, totalValue: Double, ytdValue: Double, startDate: Date) {
        self.currency = currency
        self.totalValue = totalValue
        self.ytdValue = ytdValue
        self.startDate = startDate
    }
    
}

public enum TaskCompletion<T> {
    
    case success(T)
    case failure(Error)
    
}

final class DataProvider {
    
    enum Sections {
        case summary, chart
        
        static var allSections: [Sections] = [.summary, .chart]
    }
    
    var numberOfSections = Sections.allSections
    
    // keep once fetched object while class instance exists to minimize DB querying
    private var currentClient: Client?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let assetType = AssetType.artwork
    
    func getData(in dateInterval: DateInterval, completion: ((TaskCompletion<ChartApplicable>) -> Void)) {
        var sourceClient: Client?

        // TODO: Make proxy here for object
        
        if let client = currentClient {
            sourceClient = client
        } else if let client = findLocally() {
            currentClient = client
            sourceClient = client
        } else {
            loadDataFromFile()
            if let client = findLocally() {
                sourceClient = client
            }
        }
    
        guard let client = sourceClient else {
            let error = NSError(domain: "Wealth", code: 999, userInfo: nil)
            completion(.failure(error))
            
            return
        }
        calculate(for: client, in: dateInterval, completion: completion)
    }
    
    private func calculate(for client: Client,
                           in dateInterval: DateInterval,
                           completion: ((TaskCompletion<ChartApplicable>) -> Void)) {
        
        let request: NSFetchRequest<Asset> = Asset.fetchRequest()
        request.predicate = NSPredicate(format: "client.uid = %@ AND typeRaw = %@", client.uid!, assetType.rawValue)
        request.relationshipKeyPathsForPrefetching = ["historicalValuations"]
        request.returnsObjectsAsFaults = false
        let result = try? context.fetch(request)
        
        let assets = result!
        
        let maxDate = assets.compactMap { $0.currentValuation?.date }.max()
        let currentAmount = assets.compactMap { $0.currentValuation?.inCurrency }.reduce(0.0) { $0 + $1 }
        
        let ytdValue = currentAmount - findAmount(for: assets.first!, on: maxDate!.startOfYear)
        
        var dict = [Date: Double]()
        assets.forEach { asset in
            asset.historicalValuations?
                .filter { $0.date! >= maxDate!.startOfQuarter }
                .forEach { valuation in
                    dict[valuation.date!] = dict[valuation.date!] ?? 0 + valuation.inCurrency
                }
        }
        
        let sorted = dict.sorted(by: { $0.0 < $1.0 })
        
        let wealth = WealthOfAPerson(
            currency: assets.first?.currency ?? "",
            totalValue: currentAmount,
            ytdValue: ytdValue,
            startDate: maxDate ?? Date()
        )
        wealth.chartData = sorted
        completion(.success(wealth))
    }
    
    private func findAmount(for asset: Asset, on date: Date) -> Double {
        let firstHistorical = asset.historicalValuations?.filter { $0.date! > date }.sorted(by: { $0.date! < $1.date! }).first
        
        return firstHistorical?.inCurrency ?? 0.0
    }
    
    private func findLocally() -> Client? {
        let request: NSFetchRequest<Client> = Client.fetchRequest()
        request.relationshipKeyPathsForPrefetching = ["assets"]
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print("Failed")
        }
        return nil
    }
    
    private func loadDataFromFile() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.context!] = context
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        
        guard let url = Bundle.main.url(forResource: "ngpo", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            _  = try decoder.decode([Client].self, from: data)
            context.performAndWait {
                try? context.save()
            }
        } catch {
            print("error:\(error)")
        }
    }
    
}
