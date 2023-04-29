//
//  SubTaskViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 09/04/2023.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    
    @Published var task: Task
    @Published var color: ProjectColors
    @Published private var dataSource: DataSource
    
    init(taskId: UUID, dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        
        let fetchedTask = dataSource.getTask(with: taskId)!
        let project: Project = dataSource.getProject(with: fetchedTask.projectId) ?? Project()
        
        self.task = fetchedTask
        self.color = project.color
    }
    
    var completed: Bool {
        task.state == .Completed
    }
    
    func toggleState() {
        var newTask: Task = task
        
        if (newTask.state == .ToDo) {
            newTask.state = .Completed
        } else {
            newTask.state = .ToDo
        }
        
        dataSource.updateAndSave(task: newTask)
    }
}
