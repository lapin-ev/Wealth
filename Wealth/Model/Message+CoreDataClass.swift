//
//  Message+CoreDataClass.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/19/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject, Decodable {
    
    convenience required public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Message", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        ccNames = try container.decodeIfPresent(Array<String>.self, forKey: .ccNames)
        date = try container.decodeIfPresent(Date.self, forKey: .date)
        fromName = try container.decodeIfPresent(String.self, forKey: .fromName)
        importanceLevel = try container.decodeIfPresent(Int16.self, forKey: .importanceLevel) ?? 0
        isPinned = try container.decodeIfPresent(Bool.self, forKey: .isPinned) ?? false
        isRead = try container.decodeIfPresent(Bool.self, forKey: .isRead) ?? false
        messageDescription = try container.decodeIfPresent(String.self, forKey: .messageDescription)
        subject = try container.decodeIfPresent(String.self, forKey: .subject)
        toNames = try container.decodeIfPresent(Array<String>.self, forKey: .toNames)
    }
}
