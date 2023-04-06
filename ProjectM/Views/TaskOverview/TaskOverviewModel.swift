//
//  TaskOverviewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI
import Combine


class TaskOverviewModel: ObservableObject {
    
    @Published private var dataSource: DataSource
    
    var anyCancellable: AnyCancellable? = nil
    
    init(dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        anyCancellable = dataSource.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    var tasks: [Task] {
        dataSource.tasksArray
    }
    
    func fetchTasks() {
        dataSource.fetchTasks()
    }
    
}
