//
//  AddProjectViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import Foundation

class AddProjectViewModel: ObservableObject {
    
    @Published private var dataSource: DataSource
    
    @Published var edititingTask: Task = Task()
    
    // MARK: UI booleans
    @Published var editMode: Bool = false
    @Published var hasDeadline: Bool = false
    @Published var hasEstimation: Bool = false
    
    init(task: Task?, dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        if let editTask = task {
            self.edititingTask = editTask
            self.editMode = true
            self.hasDeadline = editTask.deadline != nil
            self.hasEstimation = editTask.estimation != 0.0
        }
    }
    
    func submit() -> Bool {
        
        if (!hasDeadline) {
            edititingTask.deadline = nil
        }
        
        if (!hasEstimation) {
            edititingTask.estimation = nil
        }
        
        dataSource.updateAndSave(task: edititingTask)
        
        return true
    }
    
}
