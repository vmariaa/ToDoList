//
//  TaskTabView.swift
//  ToDoList
//
//  Created by Vanda S. on 01/02/2024.
//

import SwiftUI

struct TaskTabView: View {
    
    var body: some View {
        TabView {
            AllTasksView()
                .tabItem {
                    Image(systemName: "highlighter")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                }
        }
    }
}

#Preview {
    TaskTabView()
}
