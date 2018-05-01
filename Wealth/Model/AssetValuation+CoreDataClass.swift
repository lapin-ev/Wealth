//
//  AssetValuation+CoreDataClass.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/19/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AssetValuation)
public class AssetValuation: NSManagedObject, Decodable {

    convenience required public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "AssetValuation", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decodeIfPresent(Date.self, forKey: .date)
        inGBP = try container.decodeIfPresent(Double.self, forKey: .inGBP) ?? 0.0
        inCurrency = try container.decodeIfPresent(Double.self, forKey: .inCurrency) ?? 0.0
    }
    
}
