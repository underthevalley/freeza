//
//  CoreDataStack.swift
//  freeza
//
//  Created by Nat Sibaja on 12/30/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
     static let shared = CoreDataStack()
     private override init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "freeza")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

 }
