//
//  AddProjectViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import Foundation

class AddProjectViewModel: ObservableObject {
    
    @Published private var dataSource: DataSource
    
    @Published var editingProject: Project = Project()
    
    // MARK: UI booleans
    @Published var editMode: Bool = false
    @Published var hasDeadline: Bool = false
    @Published var hasEstimation: Bool = false
    
    init(project: Project?, dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        if let editProject = project {
            self.editingProject = editProject
            self.editMode = true
            self.hasDeadline = editProject.deadline != nil
            self.hasEstimation = editProject.estimation != 0.0
        }
    }
    
    func delete() -> Void {
        dataSource.delete(project: editingProject)
    }
    
    func submit() -> Bool {
        
        if (!hasDeadline) {
            editingProject.deadline = nil
        }
        
        if (!hasEstimation) {
            editingProject.estimation = nil
        }
        
        dataSource.updateAndSave(project: editingProject)
        
        return true
    }
    
}
