//
//  ProjectMO+CoreDataProperties.swift
//  ProjectM
//
//  Created by Niklas Børner on 23/04/2023.
//
//

import Foundation
import CoreData


extension ProjectMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectMO> {
        return NSFetchRequest<ProjectMO>(entityName: "ProjectMO")
    }

    @NSManaged public var color: ProjectColors
    @NSManaged public var deadline: Date?
    @NSManaged public var estimation: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var state: TaskState
    @NSManaged public var timestamp: Date?
    @NSManaged public var tasks: NSSet?
    @NSManaged public var timesheets: NSSet?

}

// MARK: Generated accessors for tasks
extension ProjectMO {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskMO)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskMO)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

// MARK: Generated accessors for timesheets
extension ProjectMO {

    @objc(addTimesheetsObject:)
    @NSManaged public func addToTimesheets(_ value: TimesheetMO)

    @objc(removeTimesheetsObject:)
    @NSManaged public func removeFromTimesheets(_ value: TimesheetMO)

    @objc(addTimesheets:)
    @NSManaged public func addToTimesheets(_ values: NSSet)

    @objc(removeTimesheets:)
    @NSManaged public func removeFromTimesheets(_ values: NSSet)

}

extension ProjectMO : Identifiable {

}
