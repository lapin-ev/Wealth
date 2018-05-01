//
//  Client+CoreDataProperties.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/19/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var uid: String?
    @NSManaged public var name: String?
    @NSManaged public var assets: Set<Asset>?
    @NSManaged public var drafts: Set<Message>?
    @NSManaged public var inboxMessages: Set<Message>?
    @NSManaged public var sentItems: Set<Message>?
    
    enum CodingKeys: String, CodingKey {
        
        case uid = "_id"
        case name = "clientName"
        case assets
        case drafts
        case inboxMessages
        case sentItems
    }

}

// MARK: Generated accessors for assets
extension Client {

    @objc(addAssetsObject:)
    @NSManaged public func addToAssets(_ value: Asset)

    @objc(removeAssetsObject:)
    @NSManaged public func removeFromAssets(_ value: Asset)

    @objc(addAssets:)
    @NSManaged public func addToAssets(_ values: Set<Asset>)

    @objc(removeAssets:)
    @NSManaged public func removeFromAssets(_ values: Set<Asset>)

}

// MARK: Generated accessors for drafts
extension Client {

    @objc(addDraftsObject:)
    @NSManaged public func addToDrafts(_ value: Message)

    @objc(removeDraftsObject:)
    @NSManaged public func removeFromDrafts(_ value: Message)

    @objc(addDrafts:)
    @NSManaged public func addToDrafts(_ values: Set<Message>)

    @objc(removeDrafts:)
    @NSManaged public func removeFromDrafts(_ values: Set<Message>)

}

// MARK: Generated accessors for inboxMessages
extension Client {

    @objc(addInboxMessagesObject:)
    @NSManaged public func addToInboxMessages(_ value: Message)

    @objc(removeInboxMessagesObject:)
    @NSManaged public func removeFromInboxMessages(_ value: Message)

    @objc(addInboxMessages:)
    @NSManaged public func addToInboxMessages(_ values: Set<Message>)

    @objc(removeInboxMessages:)
    @NSManaged public func removeFromInboxMessages(_ values: Set<Message>)

}

// MARK: Generated accessors for sentItems
extension Client {

    @objc(addSentItemsObject:)
    @NSManaged public func addToSentItems(_ value: Message)

    @objc(removeSentItemsObject:)
    @NSManaged public func removeFromSentItems(_ value: Message)

    @objc(addSentItems:)
    @NSManaged public func addToSentItems(_ values: Set<Message>)

    @objc(removeSentItems:)
    @NSManaged public func removeFromSentItems(_ values: Set<Message>)

}
