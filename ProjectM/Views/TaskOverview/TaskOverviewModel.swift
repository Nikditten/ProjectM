//
//  TaskOverviewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI
import Combine


class TaskOverviewModel: ObservableObject {
    
    @Published private var dataSource: DataSource
    
    @Published var isSorting: Bool = true
    
    @Published var taskToEdit: Task? = nil
    
    var anyCancellable: AnyCancellable? = nil
    
    init(dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        anyCancellable = dataSource.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    var tasks: [Task] {
        dataSource.tasksArray
    }
    
    func fetchTasks() {
        dataSource.fetchTasks()
    }
    
    func toggleState(task: Task) {
        var newTask: Task = task
        
        if (task.state == .Completed) {
            newTask.state = .ToDo
        } else {
            newTask.state = .Completed
        }
        
        dataSource.updateAndSave(task: newTask)
    }
    
    func deleteTask(task: Task) {
        dataSource.delete(task: task)
    }
    
}
