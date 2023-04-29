//
//  TaskMO+CoreDataProperties.swift
//  ProjectM
//
//  Created by Niklas Børner on 23/04/2023.
//
//

import Foundation
import CoreData


extension TaskMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskMO> {
        return NSFetchRequest<TaskMO>(entityName: "TaskMO")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var state: TaskState
    @NSManaged public var timestamp: Date?
    @NSManaged public var project: ProjectMO?

}

extension TaskMO : Identifiable {

}
