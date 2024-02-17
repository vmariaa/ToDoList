//
//  UICalendarView.swift
//  ToDoList
//
//  Created by Vanda S. on 01/02/2024.
//

import SwiftUI

struct EventCalendar: UIViewRepresentable {
    
    let timeInterval: DateInterval

    @Binding var displayedTask: FetchedResults<Task>.Element?
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "completionDate", ascending: false)]) var allTask: FetchedResults<Task>

    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = timeInterval
        view.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
        context.coordinator.allTask = allTask
        var dateComponents = [DateComponents]()
        if !AllTasks.createdTask.isEmpty {
            for task in AllTasks.createdTask {
                let dateComponent = uiView.calendar.dateComponents(in: .current, from: task)
                dateComponents.append(dateComponent)
            }
        }

        if !AllTasks.deletedTasks.isEmpty {
            for task in AllTasks.deletedTasks {
                var dateComponent = uiView.calendar.dateComponents(in: .current, from: task)
                for date in dateComponents {
                    if date.date?.startOfDay == task.startOfDay {
                        return
                    }
                }
                dateComponents.append(dateComponent)
            }
        }
        
        if !dateComponents.isEmpty {
            for date in dateComponents {
                if date.date?.startOfDay == context.coordinator.selectedDate?.date?.startOfDay {
                    AllTasks.changeTaskView(date: date, task: &context.coordinator.parent.displayedTask, allTask: allTask)
                }
            }
        }
        
        uiView.reloadDecorations(forDateComponents: dateComponents, animated: true)
        AllTasks.deletedTasks = []
        AllTasks.createdTask = []
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, allTask: allTask)
    }
    
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate{
      
        var parent: EventCalendar
        var allTask: FetchedResults<Task>
        var selectedDate: DateComponents?
        
        
        init(parent: EventCalendar, allTask: FetchedResults<Task>) {
            self.parent = parent
            self.allTask = allTask
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let fetchedTasks = allTask
                .filter { $0.completionDate?.startOfDay == dateComponents.date?.startOfDay }
            if fetchedTasks.isEmpty {
                return nil
            }
            return .image(UIImage(systemName: "circle.fill"), color: UIColor( Priority.priorityColor(fetchedTasks[0].priority!)), size: .medium)
        }
        
        @MainActor
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            selectedDate = selection.selectedDate
            AllTasks.changeTaskView(date: dateComponents!, task: &parent.displayedTask, allTask: allTask) }
 
    }
}
