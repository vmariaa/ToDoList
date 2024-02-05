//
//  NewTaskViewModel.swift
//  ToDoList
//
//  Created by Vanda S. on 20/01/2024.
//

import SwiftUI

final class NewTask: ObservableObject {
    @Published var title: String = ""
    @Published var selectedPriority: Priority = .medium
    @Published var showAlert: Bool = false
    @Published var date = Date()
}
