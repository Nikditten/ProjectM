//
//  TaskOverviewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import Foundation


class TaskOverviewModel: ObservableObject {
    
    let dbController: PersistenceController = PersistenceController.shared
    
    @Published var tasks: [Task] = []
    
    init () {
        refreshTasks()
    }
    
    func refreshTasks() {
        tasks = dbController.fetchAllTasks()
        print(tasks[0])
    }
    
}
