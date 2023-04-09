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
    
    func add() -> Void {
        
        newSubTask.taskId = task.id
        
        dataSource.updateAndSave(subTask: newSubTask)
        
        newSubTask = SubTask(taskId: task.id)
    
    }
    
}

