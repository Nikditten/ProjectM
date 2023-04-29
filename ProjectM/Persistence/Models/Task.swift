//
//  SubTask.swift
//  ProjectM
//
//  Created by Niklas Børner on 02/04/2023.
//

import SwiftUI

struct Task: Identifiable, Hashable {
    var id: UUID
    var title: String
    var description: String?
    var state: TaskState
    var timestamp: Date
    var projectId: UUID
    
    init(title: String = "", description: String? = nil , state: TaskState = TaskState.ToDo, timestamp: Date = Date(), projectId: UUID) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.state = state
        self.timestamp = timestamp
        self.projectId = projectId
    }
}

extension Task {
    func completed() -> Bool {
        return self.state == .Completed
    }
}
