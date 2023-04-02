//
//  AddProjectViewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import Foundation

class AddProjectViewModel: ObservableObject {
    
    private let dbController: PersistenceController
    
    @Published var projectName: String = ""
    @Published var projectDeadline: Date = Date()
    @Published var projectHours: Double = 0.0
    @Published var projectNote: String = ""
    @Published var projectColor: ProjectColors = ProjectColors.standard
    
    @Published var hasDeadline: Bool = false
    @Published var hasEstimation: Bool = false
    
    init(taskId: UUID? = nil) {
        dbController = PersistenceController.shared
        if (taskId != nil) {
            let task = dbController.fetchTaskById(taskId!)
            projectName = task?.name ?? ""
            projectDeadline = task?.deadline ?? Date()
            projectHours = task?.estimation ?? 0.0
            projectNote = task?.note ?? ""
            projectColor = ProjectColors(rawValue: (task?.color!)!)!
            
            hasDeadline = task?.deadline != nil ? true : false
            hasEstimation = task?.estimation != 0.0 ? true : false
        }
    }
    
    
    func add() -> Bool {
        let newTask = Task(context: dbController.viewContext)
        
        newTask.id = UUID()
        
        newTask.name = projectName
        newTask.note = projectNote
        
        newTask.deadline = hasDeadline ? projectDeadline : nil
        newTask.estimation = hasEstimation ? projectHours : 0.0
        
        newTask.color = projectColor.toString()
        
        newTask.timestamp = Date()
        
        var success = false
        
        do {
            try dbController.add(newTask)
            success = true
        } catch {
            print(error)
        }
        
        return success
    }
    
}
