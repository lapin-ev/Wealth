//
//  Message+CoreDataProperties.swift
//  WealthOfAPerson
//
//  Created by Jack Lapin on 4/19/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }
    
    @NSManaged public var ccNames: Array<String>?
    @NSManaged public var date: Date?
    @NSManaged public var fromName: String?
    @NSManaged public var importanceLevel: Int16
    @NSManaged public var isPinned: Bool
    @NSManaged public var isRead: Bool
    @NSManaged public var messageDescription: String?
    @NSManaged public var subject: String?
    @NSManaged public var toNames: Array<String>?
    
    enum CodingKeys: String, CodingKey {
        
        case ccNames
        case date = "messageDate"
        case fromName
        case importanceLevel
        case isPinned
        case isRead
        case messageDescription = "description"
        case subject
        case toNames
    }

}
