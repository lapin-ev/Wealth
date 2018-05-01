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


extension Asset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: "Asset")
    }

    @NSManaged public var assetDescription: String?
    @NSManaged public var category: String?
    @NSManaged public var currency: String?
    @NSManaged public var startingDate: Date?
    @NSManaged public var type: String?
    @NSManaged public var currentValuation: AssetValuation?
    @NSManaged public var historicalValuations: Set<AssetValuation>?
    
    @NSManaged public var client: Client?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "assetType"
        case assetDescription
        case category
        case currency
        case startingDate
        case currentValuation
        case historicalValuations
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
