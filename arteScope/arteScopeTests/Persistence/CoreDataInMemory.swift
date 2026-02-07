//
//  CoreDataInMemory.swift
//  arteScopeTests
//
//  Created by tiago on 07/02/2026.
//

import Foundation
import CoreData

@testable import arteScope

struct MemoryCoreData{
    
    static func makeInMemoryContext() -> NSManagedObjectContext {
        let container = NSPersistentContainer(name: "arteScope")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading in-memory store: \(error)")
            }
        }
        
        return container.viewContext
    }
    
}
