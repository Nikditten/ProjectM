//
//  AddProjectViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import Foundation

class AddProjectViewModel: ObservableObject {
    
    @Published private var dataSource: DataSource
    
    @Published var editMode = false
    
    @Published var title = ""
    @Published var description = ""
    @Published var color = ProjectColors.standard
    @Published var deadline = Date()
    @Published var estimation = 0.0
    
    init(task: Task?, dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        if (task != nil) {
            self.editMode = true
            self.title = task?.title ?? ""
            self.description = task?.description ?? ""
            self.color = task?.color ?? ProjectColors.standard
            self.deadline = task?.deadline ?? Date()
            self.estimation = task?.estimation ?? 0.0
        }
    }
    
    @Published var hasDeadline: Bool = false
    @Published var hasEstimation: Bool = false
    
    func submit() -> Bool {
        var task = Task()
        task.title = title
        task.description = description
        task.color = color
        
        if (hasDeadline) {
            task.deadline = deadline
        }
        
        if (hasEstimation) {
            task.estimation = estimation
        }
        
        dataSource.updateAndSave(task: task)
        
        return true
    }
    
}
