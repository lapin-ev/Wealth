//
//  Asset+CoreDataProperties.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/19/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//
//

import Foundation
import CoreData

public enum AssetType: String {
    
    case equity = "EQUITY_QUOTED"
    case privateFunds = "PRIVATE_FUNDS"
    case marineAviation = "MARINE_AVIATION"
    case realEstate = "REAL_ESTATE"
    case chattles = "CHATTLES"
    case artwork = "ARTWORK"
    case unknown
}


extension Asset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: "Asset")
    }

    @NSManaged public var assetDescription: String?
    @NSManaged public var category: String?
    @NSManaged public var currency: String?
    @NSManaged public var startingDate: Date?
    @NSManaged public var typeRaw: String?
    @NSManaged public var currentValuation: AssetValuation?
    @NSManaged public var historicalValuations: Set<AssetValuation>?
    
    @NSManaged public var client: Client?
    
    enum CodingKeys: String, CodingKey {
        
        case typeRaw = "assetType"
        case assetDescription
        case category
        case currency
        case startingDate
        case currentValuation
        case historicalValuations
    }
    
    var type: AssetType {
        get {
            if let typeRaw = typeRaw {
                return AssetType(rawValue: typeRaw)!
            } else {
                return AssetType.unknown
            }
        }
    }

}

// MARK: Generated accessors for historicalValuations
extension Asset {

    @objc(addHistoricalValuationsObject:)
    @NSManaged public func addToHistoricalValuations(_ value: AssetValuation)

    @objc(removeHistoricalValuationsObject:)
    @NSManaged public func removeFromHistoricalValuations(_ value: AssetValuation)

    @objc(addHistoricalValuations:)
    @NSManaged public func addToHistoricalValuations(_ values: Set<AssetValuation>)

    @objc(removeHistoricalValuations:)
    @NSManaged public func removeFromHistoricalValuations(_ values: Set<AssetValuation>)

}
