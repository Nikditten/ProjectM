//
//  TimesheetMO+CoreDataProperties.swift
//  ProjectM
//
//  Created by Niklas Børner on 23/04/2023.
//
//

import Foundation
import CoreData


extension TimesheetMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimesheetMO> {
        return NSFetchRequest<TimesheetMO>(entityName: "TimesheetMO")
    }

    @NSManaged public var end: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var start: Date?
    @NSManaged public var task: ProjectMO?

}

extension TimesheetMO : Identifiable {

}
