//
//  TaskDetailViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 26/03/2023.
//

import Foundation

class TaskDetailViewModel: ObservableObject {
    
    let task: Task
    
    private let dbController: PersistenceController
    
    init(taskId: UUID) {
        self.dbController = PersistenceController.shared
        self.task = dbController.fetchTaskById(taskId)!
    }
    
    @Published var showEditSheet: Bool = false
    
    // MARK: SubTask
    @Published var value: String = ""
    
    @Published var showFullDescription = false
    @Published var showInputField = false
    
    func add() -> Void {
        let newSubTask = SubTask(context: dbController.viewContext)
        
        newSubTask.id = UUID()
        
        newSubTask.name = value
        
        newSubTask.task = task
        
        do {
            try dbController.add(newSubTask)
            value = ""
        } catch {
            print(error)
        }
    
    }
    
}

