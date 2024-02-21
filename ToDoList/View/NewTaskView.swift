//
//  NewTaskView.swift
//  ToDoList
//
//  Created by Vanda S. on 16/03/2023.
//

import SwiftUI

struct NewTaskView: View {
    @StateObject var viewModel = NewTask()
    @Environment(\.dismiss) private var dismiss
    
    private func saveTask() {
        do {
            let task = Task(context: CoreDataManager.shared.viewContext)
            task.priority = viewModel.selectedPriority.rawValue
            task.name = viewModel.title
            task.dateCreated = Date()
            task.completionDate = viewModel.date
            try CoreDataManager.shared.viewContext.save()
            AllTasks.createdTask.append(task.completionDate!)
        } catch {
            print(error.localizedDescription)
        }

    }
    
    var body: some View {
        List {
            Section("NEW TASK") {
                TextField("Enter task's name", text: $viewModel.title)
                DatePicker("Completion date", selection: $viewModel.date, in: Date()..., displayedComponents: .date)
            }
            Section("PRIORITY") {
                Picker("Priority", selection: $viewModel.selectedPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.title).tag(priority)
                    }
                }
                .navigationTitle("New task")
                .pickerStyle(.segmented)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Save") {
                    if !viewModel.title.isEmpty {
                        saveTask()
                        dismiss()
                    } else {
                        viewModel.showAlert = true
                    }
                }.alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("No title!"), message: Text("Please enter a name for your task"), dismissButton: .default(Text("OK")))
                }

            }
        }
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
