//
//  SubTask.swift
//  ProjectM
//
//  Created by Niklas Børner on 02/04/2023.
//

import SwiftUI

struct SubTask: Identifiable, Hashable {
    var id: UUID
    var title: String
    var description: String?
    var state: TaskState
    var timestamp: Date
    var taskId: UUID
    
    init(title: String = "", description: String? = nil , state: TaskState = TaskState.ToDo, timestamp: Date = Date(), taskId: UUID) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.state = state
        self.timestamp = timestamp
        self.taskId = taskId
    }
}

extension SubTask {
    func completed() -> Bool {
        return self.state == .Completed
    }
}
