//
//  DBEntry+CoreDataClass.swift
//  freeza
//
//  Created by Nat Sibaja on 12/30/20.
//  Copyright © 2020 Zerously. All rights reserved.
//
//

import Foundation
import CoreData

@objc(DBEntry)
public class DBEntry: NSManagedObject {
    
    class func loadEntriesFromDB(context: NSManagedObjectContext) -> [EntryModel]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBEntry")
        var entryModel:[EntryModel] = []
        do {
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            for item in result {
                let object = item as! DBEntry
                let entry = EntryModel(withDB: object)
                entryModel.append(entry)
            }
            return entryModel
        } catch let error as NSError {
            print("Retrieiving user failed. \(error): \(error.userInfo)")
            return nil
        }
    }
    
    class func save(_ entry: EntryModel, into context: NSManagedObjectContext) {
        // Create NSManagedObject backed object
        let entryEntity = DBEntry(context: context)
        guard let date = entry.creation, let count = entry.commentsCount else { return }
        entryEntity.title = entry.title
        entryEntity.author = entry.author
        entryEntity.creation = date
        entryEntity.commentsCount = Int32(count)
        entryEntity.url = entry.url?.absoluteString
        entryEntity.thumbnailURL = entry.thumbnailURL?.absoluteString
        entryEntity.isAdult = entry.isAdult ?? false
        do {
            try context.save()
        } catch let error as NSError {
            let nserror = error as NSError
            print(nserror)
            context.delete(entryEntity)
        }
    }
    
    class func delete(_ entry: EntryModel, from context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBEntry")
        fetchRequest.predicate = NSPredicate(format: "title == %@", entry.title!)
        do {
            let objects = try! context.fetch(fetchRequest)
            let resultData = objects as! [NSManagedObject]
            for object in resultData {
                context.delete(object)
            }
            try context.save()
        } catch (let error) {
            print(error)
            return
        }
    }
}

