//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Vanda S. on 16/03/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    let viewContext: NSManagedObjectContext
    static let shared: CoreDataManager = CoreDataManager()
    
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "TaskModel")
        persistentContainer.loadPersistentStores { NSEntityDescription, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error.localizedDescription)")
            }
        }
        viewContext = persistentContainer.viewContext
    }
}


