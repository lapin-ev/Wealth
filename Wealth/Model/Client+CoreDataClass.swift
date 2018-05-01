//
//  Client+CoreDataClass.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/19/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Client)
public class Client: NSManagedObject, Decodable {
    
    convenience required public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Client", in: context) else {
                fatalError()
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        uid = try container.decodeIfPresent(String.self, forKey: .uid)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        assets = try container.decodeIfPresent(Set<Asset>.self, forKey: .assets)
        
        drafts = try container.decodeIfPresent(Set<Message>.self, forKey: .drafts)
        inboxMessages = try container.decodeIfPresent(Set<Message>.self, forKey: .inboxMessages)
        sentItems = try container.decodeIfPresent(Set<Message>.self, forKey: .sentItems)
    }

}
