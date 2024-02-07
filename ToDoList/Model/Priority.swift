//
//  Priority.swift
//  ToDoList
//
//  Created by Vanda S. on 16/03/2023.
//

import Foundation
import SwiftUI

enum Priority: String, Identifiable, CaseIterable {
    var id: UUID {
        return UUID()
    }
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    
   static func priorityColor(_ priority: String) -> Color {
        let priority = Priority(rawValue: priority)
        
        switch priority {
        case .high:
            return Color.red
        case .medium:
            return Color.yellow
        case .low:
            return Color.green
        default:
            return Color.black
        }
    }
}

extension Priority {
    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
}
