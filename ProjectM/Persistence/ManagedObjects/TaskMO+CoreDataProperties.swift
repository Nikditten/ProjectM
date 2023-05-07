//
//  TaskMO+CoreDataProperties.swift
//  ProjectM
//
//  Created by Niklas Børner on 02/04/2023.
//
//

import Foundation
import CoreData


extension TaskMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskMO> {
        return NSFetchRequest<TaskMO>(entityName: "TaskMO")
    }

    @NSManaged public var color: ProjectColors
    @NSManaged public var deadline: Date?
    @NSManaged public var estimation: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var state: TaskState
    @NSManaged public var timestamp: Date?
    @NSManaged public var subtasks: NSSet?
    @NSManaged public var timesheets: NSSet?

}

// MARK: Generated accessors for subtasks
extension TaskMO {

    @objc(addSubtasksObject:)
    @NSManaged public func addToSubtasks(_ value: SubTaskMO)

    @objc(removeSubtasksObject:)
    @NSManaged public func removeFromSubtasks(_ value: SubTaskMO)

    @objc(addSubtasks:)
    @NSManaged public func addToSubtasks(_ values: NSSet)

    @objc(removeSubtasks:)
    @NSManaged public func removeFromSubtasks(_ values: NSSet)

}

// MARK: Generated accessors for timesheets
extension TaskMO {

    @objc(addTimesheetsObject:)
    @NSManaged public func addToTimesheets(_ value: TimesheetMO)

    @objc(removeTimesheetsObject:)
    @NSManaged public func removeFromTimesheets(_ value: TimesheetMO)

    @objc(addTimesheets:)
    @NSManaged public func addToTimesheets(_ values: NSSet)

    @objc(removeTimesheets:)
    @NSManaged public func removeFromTimesheets(_ values: NSSet)

}

extension TaskMO : Identifiable {

}
