//
//  ContentView.swift
//  ToDoList
//
//  Created by Vanda S. on 15/03/2023.
//

import SwiftUI

struct AllTasksView: View {
    
    @StateObject var viewModel = AllTasks()

    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "completionDate", ascending: false)]) private var allTask: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(allTask) { task in
                        HStack{
                            Circle()
                                .fill(Priority.priorityColor(task.priority!))
                                .frame(width: 15, height: 15)
                            Spacer().frame(width: 20)
                            VStack(alignment: .leading) {
                                Text(task.name ?? "")
                                Text(viewModel.dateFormatter.string(from: task.completionDate!))
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            viewModel.doTask(task.isDone)
                                .onTapGesture {
                                    if task.isDone {
                                        task.isDone = false } else {
                                            task.isDone = true
                                    }
                                    try? CoreDataManager.shared.viewContext.save()
                                }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        NewTaskView()
                            .navigationTitle("New task")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("To do")
        }
    }
    
    private func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let task = allTask[offset]
            AllTasks.deletedTasks.append(task.completionDate!)
            CoreDataManager.shared.viewContext.delete(task)
        }
        try? CoreDataManager.shared.viewContext.save()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllTasksView()
    }
}
