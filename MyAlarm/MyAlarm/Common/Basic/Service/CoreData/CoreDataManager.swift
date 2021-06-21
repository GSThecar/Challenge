//
//  CoreDataManager.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/06/21.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyAlarm")
        container.loadPersistentStores { description, error in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            #if DEBUG
            if let error = error {
                print(#function, error.localizedDescription)
            }
            #endif
        }
        return container
    }()
    
    var context: NSManagedObjectContext { self.persistentContainer.viewContext }
    
    func saveContext() {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            #if DEBUG
            print(#function, error.localizedDescription)
            #endif
        }
    }
    
    func fetch(entity name: String) -> [Any] {
        do {
            let result = try context.fetch(NSFetchRequest(entityName: name))
            return result
        } catch {
            #if DEBUG
            print(#function, error.localizedDescription)
            #endif
            return []
        }
    }
}

