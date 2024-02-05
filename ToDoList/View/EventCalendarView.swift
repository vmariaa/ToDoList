//
//  UICalendarView.swift
//  ToDoList
//
//  Created by Vanda S. on 01/02/2024.
//

import SwiftUI

struct EventCalendar: UIViewRepresentable {
    
    let timeInterval: DateInterval
    var allTask: FetchedResults<Task>
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = timeInterval
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, allTask: allTask)
    }
    
    
    class Coordinator: NSObject, UICalendarViewDelegate {
        var parent: EventCalendar
        var allTask: FetchedResults<Task>
        
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
            return .image(UIImage(systemName: "circle.fill"), color: UIColor( priorityColor(fetchedTasks[0].priority!)), size: .medium)
        }
    }
}
