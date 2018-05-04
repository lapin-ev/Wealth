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

public enum TaskCompletion<T> {
    
    case success(T)
    case failure(Error)
    
}

final class DataProvider {
    
    private var currentClient: Client?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let assetType = AssetType.realEstate
    
    func getData(in dateInterval: DateInterval, completion: ((TaskCompletion<ChartApplicable>) -> Void)) {
        var sourceClient: Client?

        // TODO: Make proxy here for object
        
        if let client = currentClient {
            sourceClient = client
        } else if let client = findInLocalDatabase() {
            currentClient = client
            sourceClient = client
        } else {
            loadDataFromFile()
            if let client = findInLocalDatabase() {
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
        
        guard let assets = result else {
            completion(.failure(NSError(domain: "Wealth", code: 999, userInfo: nil)))
            
            return
        }
        
        let maxDate = assets.compactMap { $0.currentValuation?.date }.max() ?? Date()
        let currentAmount = assets.compactMap { $0.currentValuation?.inCurrency }.reduce(0.0) { $0 + $1 }
        
        let ytdValue = currentAmount - findAmount(for: assets, on: maxDate.startOfYear)
        
        var valuations = [Date: Double]()
        assets.forEach { $0.historicalValuations?
            .filter { $0.date! >= maxDate.startOfQuarter }
            .forEach { valuations[$0.date!] = valuations[$0.date!] ?? 0 + $0.inCurrency }
        }
        
        let wealth = WealthOfAPerson(
            currency: assets.first?.currency ?? "",
            totalValue: currentAmount,
            ytdValue: ytdValue,
            startDate: maxDate
        )
        wealth.chartData = valuations.sorted(by: { $0.0 < $1.0 })
        completion(.success(wealth))
    }
    
    private func findAmount(for assets: [Asset], on date: Date) -> Double {
        var firstAmount = 0.0
        assets.forEach { firstAmount = firstAmount + self.valuationsValue(for: $0, on: date) }
    
        return firstAmount
    }
    
    private func valuationsValue(for asset: Asset, on date: Date) -> Double {
        return asset.historicalValuations?
            .filter { $0.date! < date }
            .sorted(by: { $0.date! > $1.date! })
            .first?.inCurrency ?? 0.0
    }
    
    private func findInLocalDatabase() -> Client? {
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
