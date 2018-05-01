//
//  Asset+CoreDataClass.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/19/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Asset)
public class Asset: NSManagedObject, Decodable {

    convenience required public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Asset", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decodeIfPresent(String.self, forKey: .type)
        assetDescription = try container.decodeIfPresent(String.self, forKey: .assetDescription)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        startingDate = try container.decodeIfPresent(Date.self, forKey: .startingDate)
        currentValuation = try container.decodeIfPresent(AssetValuation.self, forKey: .currentValuation)
        historicalValuations = try container.decodeIfPresent(Set.self, forKey: .historicalValuations)
    }
}
