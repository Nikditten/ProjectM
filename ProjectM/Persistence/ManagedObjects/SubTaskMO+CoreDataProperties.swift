//
//  SubTaskMO+CoreDataProperties.swift
//  ProjectM
//
//  Created by Niklas Børner on 02/04/2023.
//
//

import Foundation
import CoreData


extension SubTaskMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTaskMO> {
        return NSFetchRequest<SubTaskMO>(entityName: "SubTaskMO")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var state: TaskState
    @NSManaged public var timestamp: Date?
    @NSManaged public var task: TaskMO?

}

extension SubTaskMO : Identifiable {

}
