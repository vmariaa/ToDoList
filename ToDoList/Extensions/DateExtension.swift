//
//  DateExtension.swift
//  ToDoList
//
//  Created by Vanda S. on 02/02/2024.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
