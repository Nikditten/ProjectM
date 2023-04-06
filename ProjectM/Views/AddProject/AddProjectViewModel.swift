//
//  AddProjectViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import Foundation

class AddProjectViewModel: ObservableObject {
    
    @Published private var dataSource: DataSource
    
    @Published var editingTask: Task = Task()
    
    init(task: Task?, dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        if (task != nil) {
            self.editingTask = task!
        }
    }
    
    func submit() -> Void {
        dataSource.updateAndSave(task: editingTask)
    }
    
}
