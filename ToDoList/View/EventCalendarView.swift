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
        for task in context.coordinator.allTask {
            var dateComponent = uiView.calendar.dateComponents(in: .current, from: task.completionDate!)
            dateComponents.append(dateComponent)
            
        }
        uiView.reloadDecorations(forDateComponents: dateComponents, animated: true)
        print(dateComponents)

        
        
        print(context.coordinator.allTask.count)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, allTask: allTask)
    }
    
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate{
      
        var parent: EventCalendar
        var allTask: FetchedResults<Task>
        
        
        init(parent: EventCalendar, allTask: FetchedResults<Task>) {
            self.parent = parent
            self.allTask = allTask
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            print("all: \(allTask.count)")
            let fetchedTasks = allTask
                .filter { $0.completionDate?.startOfDay == dateComponents.date?.startOfDay }
            print("fetched: \(fetchedTasks.count)")
            if fetchedTasks.isEmpty {
                return nil
            }
            return .image(UIImage(systemName: "circle.fill"), color: UIColor( Priority.priorityColor(fetchedTasks[0].priority!)), size: .medium)
        }
        
        
        
        
        
        @MainActor
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            print("clicked")
            let fetchedTask = allTask
                .filter { $0.completionDate?.startOfDay == dateComponents?.date?.startOfDay }
            if !fetchedTask.isEmpty {
                parent.displayedTask = fetchedTask.first
            } else {
                parent.displayedTask = nil
            }
        }
    }
}
