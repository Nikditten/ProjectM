//
//  TaskOverviewModel.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI
import Combine


class ProjectOverviewModel: ObservableObject {
    
    @Published private var dataSource: DataSource
    
    @Published var isSorting: Bool = true
    
    @Published var projectToEdit: Project? = nil
    
    var anyCancellable: AnyCancellable? = nil
    
    init(dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        anyCancellable = dataSource.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    var projects: [Project] {
        dataSource.projectsArray
    }
    
    func fetchProjects() {
        dataSource.fetchProjects()
    }
    
}
