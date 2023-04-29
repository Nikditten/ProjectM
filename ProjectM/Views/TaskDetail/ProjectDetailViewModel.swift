//
//  TaskDetailViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 26/03/2023.
//

import SwiftUI
import Combine

class ProejctDetailViewModel: ObservableObject {
    
    @Published var project: Project
    
    // MARK: Task
    @Published var newTask: Task
    
    @Published private var dataSource: DataSource
    
    var anyCancellable: AnyCancellable? = nil
    
    init(project: Project, dataSource: DataSource = DataSource.shared) {
        self.project = project
        self.newTask = Task(projectId: project.id)
        self.dataSource = dataSource
        anyCancellable = dataSource.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    @Published var showEditSheet: Bool = false
    @Published var showInputField: Bool = false
    
    var progression: Double {
        if (project.hasTasks()) {
            var completedTasks: Double = 0
            let tasks: [Task] = dataSource.tasks.values.filter { $0.projectId == project.id }
            for task in tasks {
                if (task.completed()) {
                    completedTasks += 1
                }
            }
            
            return completedTasks / Double(tasks.count)
        } else {
            return 0
        }
    }
    
    var markAsCompleted: Bool {
        project.completed || progression == 1
    }
    
    func toggleState() {
        var newProject: Project = project
        
        if (progression != 1) {
            if (project.state == .ToDo) {
                newProject.state = .Completed
            } else {
                newProject.state = .ToDo
            }
        }
        
        dataSource.updateAndSave(project: newProject)
    }
    
    func add() -> Void {
        
        newTask.projectId = project.id
        
        dataSource.updateAndSave(task: newTask)
        
        newTask = Task(projectId: project.id)
        
    }
    
}

