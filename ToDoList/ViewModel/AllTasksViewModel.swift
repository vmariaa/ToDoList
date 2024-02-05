//
//  AllTasksViewModel.swift
//  ToDoList
//
//  Created by Vanda S. on 20/01/2024.
//

import SwiftUI
import CoreData

final class AllTasks: ObservableObject {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
        return formatter
    }()
    
    func doTask(_ finished: Bool) -> Image {
        switch finished {
        case true:
            return Image(systemName: "checkmark.circle")
        case false:
            return Image(systemName: "circle")
        }
    }
    
}
