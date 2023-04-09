//
//  SubTaskViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 09/04/2023.
//

import Foundation
import SwiftUI

class SubTaskViewModel: ObservableObject {
    
    @Published var subTask: SubTask
    @Published var color: ProjectColors
    @Published private var dataSource: DataSource
    
    init(subTaskId: UUID, dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        
        let fetchedSubTask = dataSource.getSubTask(with: subTaskId)!
        let task: Task = dataSource.getTask(with: fetchedSubTask.taskId)!
        
        self.subTask = fetchedSubTask
        self.color = task.color
    }
    
    var completed: Bool {
        subTask.state == .Completed
    }
    
    func toggleState() {
        var newSubTask: SubTask = subTask
        
        if (subTask.state == .ToDo) {
            newSubTask.state = .Completed
        } else {
            newSubTask.state = .ToDo
        }
        
        dataSource.updateAndSave(subTask: newSubTask)
    }
}
