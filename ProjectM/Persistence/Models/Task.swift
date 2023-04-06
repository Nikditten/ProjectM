//
//  Task.swift
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
    var color: ProjectColors
    var deadline: Date?
    var estimation: Double?
    var timestamp: Date
    var subtasks: [UUID]
    
    init(title: String = "", description: String = "", state: TaskState = TaskState.ToDo, color: ProjectColors = ProjectColors.standard, deadline: Date? = nil, estimation: Double? = nil, timestamp: Date = Date(), subtasks: [UUID] = []) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.state = state
        self.color = color
        self.deadline = deadline
        self.estimation = estimation
        self.timestamp = timestamp
        self.subtasks = subtasks
    }
}
