//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Vanda S. on 15/03/2023.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            TaskTabView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
