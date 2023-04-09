//
//  TaskDetailViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 26/03/2023.
//

import SwiftUI
import Combine

class TaskDetailViewModel: ObservableObject {
    
    @Published var task: Task
    
    // MARK: SubTask
    @Published var newSubTask: SubTask
    
    @Published private var dataSource: DataSource
    
    var anyCancellable: AnyCancellable? = nil
    
    init(task: Task, dataSource: DataSource = DataSource.shared) {
        self.task = task
        self.newSubTask = SubTask(taskId: task.id)
        self.dataSource = dataSource
        anyCancellable = dataSource.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    @Published var showEditSheet: Bool = false
    @Published var showInputField: Bool = false
    
    var progression: Double {
        if (task.hasSubTasks()) {
            var completedSubTasks: Double = 0
            let subtasks: [SubTask] = dataSource.subTasks.values.filter { $0.taskId == task.id }
            for subtask in subtasks {
                if (subtask.completed()) {
                    completedSubTasks += 1
                }
            }
            
            return completedSubTasks / Double(subtasks.count)
        } else {
            return 0
        }
    }
    
    var markAsCompleted: Bool {
        task.completed || progression == 1
    }
    
    func toggleState() {
        var newTask: Task = task
        
        if (progression != 1) {
            if (task.state == .ToDo) {
                newTask.state = .Completed
            } else {
                newTask.state = .ToDo
            }
        }
        
        dataSource.updateAndSave(task: newTask)
    }
    
    func add() -> Void {
        
        newSubTask.taskId = task.id
        
        dataSource.updateAndSave(subTask: newSubTask)
        
        newSubTask = SubTask(taskId: task.id)
        
    }
    
}

