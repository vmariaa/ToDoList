//
//  CalendarView.swift
//  ToDoList
//
//  Created by Vanda S. on 01/02/2024.
//

import SwiftUI



struct CalendarView: View {
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "completionDate", ascending: false)]) private var allTask: FetchedResults<Task>
    @StateObject var viewModel = AllTasks()
    @State var displayedTask: FetchedResults<Task>.Element?
    
    var body: some View {
        ScrollView {
            VStack{
                EventCalendar(timeInterval: DateInterval(start: .distantPast, end: .distantFuture), 
                              displayedTask: $displayedTask)

                if displayedTask != nil {
                    HStack{
                        Circle()
                            .fill(Priority.priorityColor(displayedTask!.priority!))
                            .frame(width: 15, height: 15)
                        Spacer().frame(width: 20)
                        VStack(alignment: .leading) {
                            Text(displayedTask!.name ?? "")
                            Text(viewModel.dateFormatter.string(from: displayedTask!.completionDate!))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                    }
                } else {
                    Text("No task for that day")
                    
                }
            }
        }
    }
    
}
