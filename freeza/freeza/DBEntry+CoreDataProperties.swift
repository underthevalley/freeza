//
//  DBEntry+CoreDataProperties.swift
//  freeza
//
//  Created by Nat Sibaja on 12/30/20.
//  Copyright © 2020 Zerously. All rights reserved.
//
//

import Foundation
import CoreData


extension DBEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBEntry> {
        return NSFetchRequest<DBEntry>(entityName: "DBEntry")
    }

    @NSManaged public var author: String?
    @NSManaged public var commentsCount: Int32
    @NSManaged public var creation: Date
    @NSManaged public var isAdult: Bool
    @NSManaged public var thumbnailURL: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
