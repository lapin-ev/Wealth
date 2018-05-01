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

protocol ChartApplicable: class {
    
    var someInfo: Array<Double> { get set }
}

class WealthOfAPerson: ChartApplicable {
    
    var someInfo: Array<Double> = []
    
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
    
    func getData(in dateInterval: DateInterval, completion: ((TaskCompletion<ChartApplicable>) -> Void)) {
        var sourceClient: Client?

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
        request.predicate = NSPredicate(format: "client.name = %@ AND type = %@", client.name!, "ARTWORK")
        request.relationshipKeyPathsForPrefetching = ["historicalValuations"]
        request.returnsObjectsAsFaults = false
        let result = try? context.fetch(request)
        
        let assets = result!
        
        let maxDate = assets.compactMap { $0.currentValuation?.date }.max()
        let currentAmount = assets.compactMap { $0.currentValuation?.inCurrency }.reduce(0.0) { $0 + $1 }
        
        let amountForDate = assets.compactMap { $0.historicalValuations?.filter { String(describing: $0.date) == "2015-12-31 18:30:00 +0000"} }
        
        var dict = [Date: Double]()
        assets.forEach { asset in
            asset.historicalValuations?.forEach { valuation in
                dict[valuation.date!] = dict[valuation.date!] ?? 0 + valuation.inCurrency
            }
        }

        print(dict.sorted(by: { $0.0 < $1.0 }))

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
