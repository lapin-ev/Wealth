//
//  AssetValuation+CoreDataProperties.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/19/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//
//

import Foundation
import CoreData

extension AssetValuation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AssetValuation> {
        return NSFetchRequest<AssetValuation>(entityName: "AssetValuation")
    }

    @NSManaged public var date: Date?
    @NSManaged public var inCurrency: Double
    @NSManaged public var inGBP: Double
    
    @NSManaged public var asset: Asset?
    @NSManaged public var historical: Asset?

    
    
    enum CodingKeys: String, CodingKey {
        
        case date = "valuationDate"
        case inGBP = "valuationInGBP"
        case inCurrency = "valuationInCurrency"
    }

}
