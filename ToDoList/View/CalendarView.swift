//
//  CalendarView.swift
//  ToDoList
//
//  Created by Vanda S. on 01/02/2024.
//

import SwiftUI

struct CalendarView: View {
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTask: FetchedResults<Task>
    @StateObject var viewModel = AllTasks()
    
    var body: some View {
        ScrollView {
            VStack{
                EventCalendar(timeInterval: DateInterval(start: .distantPast, end: .distantFuture), allTask: allTask)
//                HStack{
//                    Circle()
//                        .fill(viewModel.priorityColor(allTask[0].priority!))
//                        .frame(width: 15, height: 15)
//                    Spacer().frame(width: 20)
//                    VStack(alignment: .leading) {
//                        Text(allTask[0].name ?? "")
//                        Text(viewModel.dateFormatter.string(from: allTask[0].completionDate!))
//                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
//                    }
//                    
//                }
            }
        }
    }
}
